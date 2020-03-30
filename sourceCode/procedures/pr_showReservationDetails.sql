create procedure pr_showReservationDetails
    @reservationID int
as
begin
    select C.ConferenceID, C.name conference_name, dbo.fn_conferenceReservationPrice(@reservationID) whole_price,
           DR.DayID, dateadd(day, D.day_of_conference, C.start_date) as date, WR.WorkAtConfID, WAC.WorkshopID,
           W.name workshop_name, WAC.price workshop_price
    from Reservations R
    join Conferences C on ConferenceID = dbo.fn_getReservationConference(@reservationID)
    left join [Days Reservations] DR on R.ReservationID = DR.ReservationID
    join Days D on DR.DayID = D.DayID or DR.ReservationID is null
    left join [Workshops Reservations] WR on DR.DayReservationID = WR.DayReservationID
    left join [Workshops At Conferences] WAC on WR.WorkAtConfID = WAC.WorkAtConfID
    left join Workshops W on WAC.WorkshopID = W.WorkshopID
    where DR.ReservationID = @reservationID
end
go

