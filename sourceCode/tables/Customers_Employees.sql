create table [Customers Employees]
(
    EmployeeID int identity
        constraint [PK_Customers Employees]
            primary key,
    PersonID   int not null
        constraint [IX_Customers Employees]
            unique
        constraint [FK_Customers Employees_Persons]
            references Persons,
    CompanyID  int not null
        constraint [FK_Customers Employees_Companies]
            references Companies
)
go

