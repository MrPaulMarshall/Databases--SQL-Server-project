CREATE procedure pr_addWorkshopEnrollment @workshopReservationID int,
                                          @dayEnrollmentID int
as
begin
    set nocount on

    declare @workshopReservation int = (select WorkshopReservationID from [Workshops Reservations] where WorkshopReservationID = @workshopReservationID)
    if(@workshopReservation is null)
        throw 52000, 'There is no such workshop reservation', 1

    declare @dayEnrollment int = (select DayEnrollmentID from [Days Enrollments] where DayEnrollmentID = @dayEnrollmentID)
    if (@dayEnrollment is null)
        throw 52000, 'There is no such days enrollment', 1

    if ((select DayReservationID from [Workshops Reservations] where WorkshopReservationID = @workshopReservationID) <>
            (select DayReservationID from [Days Enrollments] where DayEnrollmentID = @dayEnrollmentID))
        throw 52000, 'Workshop reservation and day enrollment reference 2 different days reservation', 1

    declare @personID int = (select PersonID from [Days Enrollments] where DayEnrollmentID = @dayEnrollmentID)
    if (@personID is null)
        throw 52000, 'You havent given PersonID to this day enrollment yet', 1

    -- CZY NIE POKRYWA SIE Z JAKIMS WARSZTATEM NA KTORY DANA OSOBA JUZ JEST ZAPISANA
    declare @enrolledWorkshops table
    (
        WorkAtConfID int
    )
    insert @enrolledWorkshops (WorkAtConfID)
        select WorkAtConfID from [Workshops Reservations] WR
        join [Workshops Enrollments] WE on WR.WorkshopReservationID = WE.WorkshopReservationID
        where WE.DayEnrollmentID = @dayEnrollmentID

    declare @newWorkshopID int = (
        select WorkAtConfID from [Workshops Reservations] where WorkshopReservationID = @workshopReservationID
    )
    declare @enrolledWorkshopID int = null
    while(1 = 1)
    begin
        set @enrolledWorkshopID = null
        select top(1) @enrolledWorkshopID = WorkAtConfID
        from @enrolledWorkshops

        if @enrolledWorkshopID is null
            break

        -- TU SPRAWDZAM
        if (dbo.fn_workshopsCollision(@enrolledWorkshopID, @newWorkshopID) = 1)
            throw 52000, 'You have already marked presence at other workshop at that time', 1

        delete from @enrolledWorkshops where WorkAtConfID = @enrolledWorkshopID
    end

    -- SPRAWDZAM, CZY KLIENT JEST FIRMA, CZY PRYWATNYM:
    --      JESLI FIRMĄ, TO MOZE DODAĆ TYLKO SIEBIE
    --      JESLI PRYWATNYM, TO MOZE DODAC TYLKO SWOJEGO PRACOWNIKA

    declare @customerID int = (
        select CustomerID
        from Reservations R
        join [Days Reservations] [D R] on R.ReservationID = [D R].ReservationID
        join [Days Enrollments] [D E] on [D R].DayReservationID = [D E].DayReservationID
        where [D E].DayEnrollmentID = @dayEnrollmentID
    )

    if (@customerID in (select CustomerID from [Private Customers]))
    begin
        if (@personID <> (select PersonID from [Private Customers] where CustomerID = @customerID))
            throw 52000, 'You can enroll only yourself', 1
    end

    if (@customerID in (select CompanyID from Companies))
    begin
        if (@personID not in (select PersonID from [Customers Employees] where CompanyID = @customerID))
            throw 52000, 'You can enroll only your employees', 1
    end

    insert into [Workshops Enrollments] (WorkshopReservationID, DayEnrollmentID)
    values (@workshopReservationID, @dayEnrollmentID)
end
go
