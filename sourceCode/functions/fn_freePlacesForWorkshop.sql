create function fn_freePlacesForWorkshop(
    @workshopID int
)
returns int
as
begin
    declare @totalPlaces int;
    set @totalPlaces = (
        select wac.participants_limit
        from [Workshops At Conferences] as wac
        where wac.WorkAtConfID = @workshopID
    )

    declare @takenPlaces int;
    set @takenPlaces = (
        select sum(number_of_bookings)
        from [Workshops Reservations] as wr
        where wr.WorkAtConfID = @workshopID
    )

    return (@totalPlaces - @takenPlaces);
end
go

