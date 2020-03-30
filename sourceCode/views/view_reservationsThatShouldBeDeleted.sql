create view view_reservationsThatShouldBeDeleted as
select ReservationID
from Reservations
where payment_date is null and datediff(day, reservation_date, getdate()) > 7
go

