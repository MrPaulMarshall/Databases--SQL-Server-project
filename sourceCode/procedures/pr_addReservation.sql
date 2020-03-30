CREATE procedure pr_addReservation @customerID int,
                                   @reservationDate date
as
begin
    set nocount on

    declare @customer int = (select CustomerID from Customers where CustomerID = @customerID)
    if(@customer is null)
        throw 52000, 'No such customer', 1

    insert into Reservations (CustomerID, reservation_date) values (@customerID, @reservationDate)
end
go

