create function fn_numberOfStudents(
    @reservationID int
)
returns int as
begin
    declare @number int = (
        select count(*) from [Days Enrollments] as DE
        join [Days Reservations] as DR on DE.DayReservationID = DR.DayReservationID
        where DR.ReservationID = @reservationID and DE.DayEnrollmentID is not null
    )
    set @number = isnull(@number, 0)
    return @number
end
go

