create table Tresholds
(
    TresholdID    int identity
        constraint PK_Tresholds
            primary key,
    ConferenceID  int  not null
        constraint FK_Tresholds_Conferences
            references Conferences,
    starts_before int  not null,
    ends_before   int  not null,
    discount      real not null
        constraint CK__Tresholds__disco__2645B050
            check ([discount] >= 0 AND [discount] <= 1),
    constraint CK_starts_before_ends
        check ([starts_before] >= [ends_before])
)
go

