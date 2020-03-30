create table [Workshops Enrollments]
(
    WorkshopEnrollmentID  int identity
        constraint [PK_Workshops Enrollments]
            primary key,
    WorkshopReservationID int not null
        constraint [FK_Workshops Enrollments_Workshops Reservations]
            references [Workshops Reservations]
            on update cascade on delete cascade,
    DayEnrollmentID       int not null
        constraint [FK_Workshops Enrollments_Days Enrollments]
            references [Days Enrollments]
)
go

create index in_WorkshopEnrollments
    on [Workshops Enrollments] (DayEnrollmentID)
go

