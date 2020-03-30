create table Companies
(
    CompanyID    int         not null
        constraint PK_Companies
            primary key
        constraint FK_Companies_Customers
            references Customers,
    company_name varchar(60) not null,
    phone        varchar(12) not null
        check (isnumeric([phone]) = 1),
    email        varchar(40) not null
        check ([email] like '%@%.%')
)
go

