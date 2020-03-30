create procedure pr_addCompanyCustomer
@company_name varchar(60),
@phone varchar(12),
@email varchar(40)
as
declare @customerID int;
insert into Customers default values
set @customerID = isnull( (
    SELECT MAX(CustomerID) FROM Customers
), 0)
insert into Companies (CompanyID, company_name, phone, email)
    values (@customerID, @company_name, @phone, @email)
go

