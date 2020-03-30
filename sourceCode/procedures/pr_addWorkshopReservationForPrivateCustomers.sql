create procedure pr_addWorkshopReservationForPrivateCustomers
    @dayReservationID int,
    @workAtConfID int
as
begin
    set nocount on

    declare @dayReservation int = (select DayReservationID from [Days Reservations] where DayReservationID = @dayReservationID)
    if (@dayReservation is null)
        throw 5200, 'There is no such reservation', 1

    declare @workAtConf int = (select WorkAtConfID from [Workshops At Conferences] where WorkAtConfID = @workAtConfID)
    if (@workAtConf is null)
        throw 5200, 'There is no such workshop at conference', 1

    insert into [Workshops Reservations] (DayReservationID, WorkAtConfID, number_of_bookings)
        values (@dayReservationID, @workAtConfID, 1)

    declare @workshopReservationID int = (select max(WorkshopReservationID) from [Workshops Reservations])

    declare @dayEnrollmentID int = (
        select top 1 DayEnrollmentID
        from [Days Enrollments] DE
        join [Days Reservations] DR on DE.DayReservationID = DR.DayReservationID
        join [Workshops Reservations] WR on DR.DayReservationID = WR.DayReservationID
        where WR.WorkshopReservationID = @workshopReservationID
    )

    exec dbo.pr_addWorkshopEnrollment @workshopReservationID = @workshopReservationID, @dayEnrollmentID = @dayEnrollmentID
end
go

