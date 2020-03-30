create procedure pr_deleteReservation
@reservationID int
as
delete from Reservations where ReservationID = @reservationID
go

