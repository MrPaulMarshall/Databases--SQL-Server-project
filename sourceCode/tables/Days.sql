create table Days
(
    DayID             int identity
        constraint PK_Days
            primary key,
    ConferenceID      int not null
        constraint FK_Days_Conferences
            references Conferences,
    day_of_conference int not null
        constraint CK__Days__day_of_con__30C33EC3
            check ([day_of_conference] >= 0)
)
go

