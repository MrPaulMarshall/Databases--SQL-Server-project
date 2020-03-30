create table Conferences
(
    ConferenceID     int identity
        constraint PK_Conferences
            primary key,
    name             varchar(60)                             not null,
    start_date       date                                    not null,
    duration         int                                     not null
        constraint CK__Conferenc__durat__31B762FC
            check ([duration] >= 1),
    StateID          int                                     not null
        constraint FK_Conferences_States
            references States,
    city             varchar(40)                             not null,
    street           varchar(40)                             not null,
    description      varchar(256)                            not null,
    daily_price      money                                   not null
        constraint CK__Conferenc__daily__32AB8735
            check ([daily_price] >= 0),
    daily_limit      int                                     not null
        constraint CK__Conferenc__daily__339FAB6E
            check ([daily_limit] > 0),
    student_discount real
        constraint DF_Conferences_student_discount default 0 not null
        constraint CK__Conferenc__stude__3493CFA7
            check ([student_discount] >= 0 AND [student_discount] <= 1)
)
go

