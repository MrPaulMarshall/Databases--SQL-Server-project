create function fn_freePlacesForWorkshopReservation(
    @workshopReservationID int
)
returns int
as
begin
    declare @totalPlaces int;
    set @totalPlaces = (
        select number_of_bookings
        from [Workshops Reservations] as wr
        where WorkshopReservationID = @workshopReservationID
    )

    declare @takenPlaces int;
    set @takenPlaces = (
        select count(*)
        from [Workshops Enrollments] as we
        where we.WorkshopReservationID = @workshopReservationID
    )

    return (@totalPlaces - @takenPlaces);
end
go

