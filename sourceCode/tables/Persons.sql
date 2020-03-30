create table Persons
(
    PersonID        int         not null
        constraint PK_Persons
            primary key,
    firstname       varchar(30) not null,
    lastname        varchar(30) not null,
    email           varchar(40) not null
        check ([email] like '%@%.%'),
    phone           varchar(12) not null
        check (isnumeric([phone]) = 1),
    StudentIDNumber int
        constraint DF_Persons_StudentIDNumber default NULL
        check (isnumeric([StudentIDNumber]) = 1 OR [StudentIDNumber] IS NULL)
)
go

