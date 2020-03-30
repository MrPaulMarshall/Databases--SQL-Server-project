CREATE procedure pr_addDayEnrollment @dayReservationID int,
                                     @personID int = null,
                                     @studentIDNumber int = null
as
begin
    set nocount on

    declare @reservation int = (select DayReservationID
                                from [Days Reservations]
                                where DayReservationID = @dayReservationID)
    if (@reservation is null)
        throw 52000, 'There is no such reservation',1

    if (@personID is not null)
        begin
            declare @person int = (select PersonID from Persons where PersonID = @personID)
            if (@person is null)
                throw 52000, 'There is no such person',1
        end

    if (@studentIDNumber is not null)
        if(not (isnumeric(@studentIDNumber) = 1))
            throw 52000, 'Student index must consist only from numbers',1

    insert into [Days Enrollments] (DayReservationID, PersonID, StudentIDNumber)
    values (@dayReservationID, @personID, @studentIDNumber)
end
go

