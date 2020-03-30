create table [Private Customers]
(
    CustomerID int not null
        constraint [PK_Private Customers]
            primary key
        constraint [FK_Private Customers_Customers]
            references Customers,
    PersonID   int not null
        constraint [IX_Private Customers]
            unique
        constraint [FK_Private Customers_Persons]
            references Persons
)
go

