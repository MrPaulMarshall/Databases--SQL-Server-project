create procedure pr_addDayReservationForPrivateCustomer
    @reservationID int,
    @dayID int
as
begin
    set nocount on

    declare @reservation int = (select ReservationID from Reservations where ReservationID = @reservationID)
    if (@reservation is null)
        throw 52000, 'No such reservation',1

    declare @day int = (select DayID from Days where DayID = @dayID)
    if (@day is null)
        throw 52000, 'No such day',1

    insert into [Days Reservations] (DayID, ReservationID, number_of_bookings)
        values (@dayID, @reservation, 1)

    declare @dayReservationID int = (select max(DayReservationID) from [Days Reservations])

    declare @personID int = (
        select P.PersonID from Persons P
        join [Private Customers] PR on P.PersonID = PR.PersonID
        join Customers C on PR.CustomerID = C.CustomerID
        join Reservations R2 on C.CustomerID = R2.CustomerID
        where ReservationID = @reservation
    )

    declare @studentIDNumber int = (select StudentIDNumber from Persons where Persons.PersonID = @personID)

    insert into [Days Enrollments] (DayReservationID, PersonID, StudentIDNumber)
        values (@dayReservationID, @personID, @studentIDNumber)
end
go

