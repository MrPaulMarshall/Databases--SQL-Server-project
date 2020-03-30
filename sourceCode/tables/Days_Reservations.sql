create table [Days Reservations]
(
    DayReservationID   int identity
        constraint [PK_Days Reservations]
            primary key,
    DayID              int                                             not null
        constraint [FK_Days Reservations_Days]
            references Days
            on update cascade on delete cascade,
    ReservationID      int                                             not null
        constraint [FK_Days Reservations_Reservations]
            references Reservations
            on update cascade on delete cascade,
    number_of_bookings int
        constraint [DF_Days Reservations_number_of_bookings] default 1 not null
        constraint [CK__Days Rese__numbe__2DE6D218]
            check ([number_of_bookings] > 0)
)
go

create index in_DaysReservation
    on [Days Reservations] (ReservationID)
go

