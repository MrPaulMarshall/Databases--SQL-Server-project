create function fn_paymentsHistory(
    @customerID int
)
returns @paymentsTable table (
    ConferenceID int,
    total_cost money
)
as

begin
    insert @paymentsTable
        select dbo.fn_getReservationConference(ReservationID),
               dbo.fn_conferenceReservationPrice(ReservationID)
        from Reservations as r
        where CustomerID = @customerID and payment_date is not null
    return
end
go

