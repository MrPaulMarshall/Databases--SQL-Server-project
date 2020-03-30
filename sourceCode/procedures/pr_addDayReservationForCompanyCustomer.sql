CREATE procedure pr_addDayReservationForCompanyCustomer
    @reservationID int,
    @dayID int,
    @number_of_bookings int,
    @studentIDNumbers StudentIDTable readonly
as
begin
    set nocount on

    declare @reservation int = (select ReservationID from Reservations where ReservationID = @reservationID)
    if (@reservation is null)
        throw 52000, 'No such reservation',1

    declare @day int = (select DayID from Days where DayID = @dayID)
    if (@day is null)
        throw 52000, 'No such day',1

    if (@number_of_bookings <= 0)
        throw 52000, 'Number of bookings must be positive', 1

    declare @number_of_students int = (select count(*) from @studentIDNumbers)

    insert into [Days Reservations] (ReservationID, DayID, number_of_bookings)
    values (@reservationID, @dayID, @number_of_bookings)

    declare @dayReservationID int = (select max(DayReservationID) from [Days Reservations]);

    -- tworze dla studentow pola w days enrollments
    declare @studentID int
    declare @iterator int = 1
    while (@iterator <= @number_of_students) begin
        set @studentID = (
            select top 1 nt.StudentIDNumber
            from (
                select top(@iterator) StudentIDNumber
                from @studentIDNumbers
                order by StudentIDNumber
            ) as nt
            order by nt.StudentIDNumber desc
        )

        insert into [Days Enrollments] (DayReservationID, PersonID, StudentIDNumber)
            values (@dayReservationID, null, @studentID)

        set @iterator = @iterator + 1
    end
end
go

