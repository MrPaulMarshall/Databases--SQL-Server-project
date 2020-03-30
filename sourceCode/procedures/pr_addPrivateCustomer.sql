create procedure pr_addPrivateCustomer
@personID int
as
declare @customerID int;
insert into Customers default values
set @customerID = isnull( (
    SELECT MAX(CustomerID) FROM Customers
), 0)
insert into [Private Customers] (CustomerID, PersonID)
    values (@customerID, @personID)
go

