create table [Workshops At Conferences]
(
    WorkAtConfID       int identity
        constraint PK_WorkshopsAtConferences
            primary key,
    WorkshopID         int   not null
        constraint FK_WorkshopsAtConferences_Workskops
            references Workshops,
    DayID              int   not null
        constraint FK_WorkshopsAtConferences_Days
            references Days,
    start_time         time  not null,
    price              money not null
        constraint CK__Workshops__price__245D67DE
            check ([price] >= 0),
    participants_limit int
)
go

