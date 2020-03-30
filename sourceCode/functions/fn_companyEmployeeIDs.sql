create function fn_companyEmployeeIDs(
    @companyID int
)
returns table as
return
    select CE.PersonID
    from [Customers Employees] as CE
    where CE.CompanyID = @companyID
go

