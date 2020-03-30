create table States
(
    StateID int identity
        constraint PK_States
            primary key,
    state   varchar(40) not null
        constraint UC_State
            unique
)
go

