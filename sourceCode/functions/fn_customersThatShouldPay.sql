create function fn_customersThatShouldPay()
returns table as
return
    (
        select CustomerID, ReservationID, dbo.fn_getReservationConference(ReservationID) as ConferenceID,
               datediff(day, reservation_date, getdate()) as days_since_reservation
        from Reservations
        where payment_date is null
    )
go

