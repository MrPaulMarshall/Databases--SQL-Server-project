CREATE procedure pr_addWorkshopReservationForCompanyCustomer
    @dayReservationID int,
    @workAtConfID int,
    @number_of_bookings int
as
begin
    set nocount on

    declare @dayReservation int = (select DayReservationID from [Days Reservations] where DayReservationID = @dayReservationID)
    if (@dayReservation is null)
        throw 52000, 'There is no such reservation', 1

    declare @workAtConf int = (select WorkAtConfID from [Workshops At Conferences] where WorkAtConfID = @workAtConfID)
    if (@workAtConf is null)
        throw 52000, 'There is no such workshop at conference', 1

    if(@number_of_bookings <= 0)
        throw 52000, 'Number of bookings must be positive', 1

    insert into [Workshops Reservations] (DayReservationID, WorkAtConfID, number_of_bookings)
        values (@dayReservationID, @workAtConfID, @number_of_bookings)
end
go

