CREATE function [dbo].[fn_conferenceReservationPrice](
    @reservationID int
)
returns int as
begin
    declare @daysPrice money
    set @daysPrice = (
        select sum(
            daily_price * (number_of_bookings-dbo.fn_numberOfStudents(@reservationID)) +
            daily_price * (1-student_discount) * dbo.fn_numberOfStudents(@reservationID)
        )
		from Reservations as r
        inner join [Days Reservations] as dr on r.ReservationID = dr.ReservationID
        inner join Conferences C on C.ConferenceID = dbo.fn_getReservationConference(@reservationID)
        where r.ReservationID = @reservationID
    )

    declare @workshopsPrice money
    set @workshopsPrice = (
        select sum(WR.number_of_bookings * WAC.price)
		from Reservations as R
        inner join [Days Reservations] as DR on R.ReservationID = DR.ReservationID
        inner join [Workshops Reservations] as WR on DR.DayReservationID = WR.DayReservationID
        inner join [Workshops At Conferences] as WAC on WR.WorkAtConfID = WAC.WorkAtConfID
        where R.ReservationID = @reservationID
    )

	declare @discount real
    set @discount = (
        select top 1 discount
		from Reservations as r
        inner join Conferences C on dbo.fn_getReservationConference(@reservationID) = C.ConferenceID
        inner join Tresholds T on C.ConferenceID = T.ConferenceID
        where r.ReservationID = @reservationID and datediff(day, r.reservation_date, C.start_date) between T.ends_before and T.starts_before
    )
    set @discount = isnull(@discount, 0)

    return (@daysPrice * (1 - @discount) + @workshopsPrice)
end
go

