CREATE procedure pr_addDayReservation @reservationID int,
                                      @dayID int,
                                      @number_of_bookings int = 1
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

    insert into [Days Reservations] (ReservationID, DayID, number_of_bookings)
    values (@reservationID, @dayID, @number_of_bookings)
end
go

