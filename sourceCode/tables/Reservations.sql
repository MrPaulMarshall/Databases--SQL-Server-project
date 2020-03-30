create table Reservations
(
    ReservationID    int identity
        constraint PK_Reservations
            primary key,
    CustomerID       int  not null
        constraint FK_Reservations_Customers
            references Customers,
    reservation_date date not null,
    payment_date     date
        constraint DF_Reservations_payment_date default NULL,
    constraint CK_pays_after_reserves
        check ([reservation_date] < [payment_date])
)
go

