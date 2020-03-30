create procedure pr_addCustomerEmployee
@personID int,
@companyID int
as
insert into [Customers Employees] (PersonID, CompanyID)
    values (@personID, @companyID)
go

