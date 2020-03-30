create function fn_freePlacesForDayReservation(
    @dayReservationID INT
)
    returns int as
begin
    declare @freeSlots INT
    set @freeSlots = (
        select number_of_bookings - count(*) from [Days Reservations] as DR
        inner join [Days Enrollments] as DE on DR.DayReservationID = DE.DayReservationID
        where DR.DayReservationID = @dayReservationID
        group by DR.DayReservationID, number_of_bookings
        )
    return @freeSlots
end
go

