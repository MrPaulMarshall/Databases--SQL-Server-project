create table [Workshops Reservations]
(
    WorkshopReservationID int identity
        constraint [PK_Workshops Reservations]
            primary key,
    DayReservationID      int                                               not null
        constraint [FK_Workshops Reservations_Days Reservations]
            references [Days Reservations]
            on update cascade on delete cascade,
    WorkAtConfID          int                                               not null
        constraint [FK_Workshops Reservations_WorkshopsAtConferences]
            references [Workshops At Conferences]
            on update cascade on delete cascade,
    number_of_bookings    int
        constraint [DF_Workshops Reservations_number_of_bookings] default 1 not null
        constraint CK__Workshops__numbe__25518C17
            check ([number_of_bookings] >= 0)
)
go

create index in_WorkshopReservations
    on [Workshops Reservations] (DayReservationID)
go

