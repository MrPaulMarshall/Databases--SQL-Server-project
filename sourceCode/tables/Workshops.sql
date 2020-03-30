create table Workshops
(
    WorkshopID  int identity
        constraint PK_Workskops
            primary key,
    name        varchar(60)                     not null,
    syllabus    varchar(256)                    not null,
    description varchar(256)                    not null,
    price       money
        constraint DF_Workshops_price default 0 not null
        constraint CK__Workskops__price__2180FB33
            check ([price] >= 0),
    duration    int                             not null
        constraint CK__Workskops__durat__22751F6C
            check ([duration] > 0)
)
go

