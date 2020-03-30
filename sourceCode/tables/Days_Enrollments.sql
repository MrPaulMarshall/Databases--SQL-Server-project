create table [Days Enrollments]
(
    DayEnrollmentID  int identity
        constraint [PK_Days Enrollments]
            primary key,
    DayReservationID int not null
        constraint [FK_Days Enrollments_Days Reservations]
            references [Days Reservations]
            on update cascade on delete cascade,
    PersonID         int
        constraint [DF_Days Enrollments_PersonID] default NULL
        constraint [FK_Days Enrollments_Persons]
            references Persons
            on update cascade on delete cascade,
    StudentIDNumber  int
        constraint [DF_Days Enrollments_StudentIDNumber] default NULL
)
go

create index in_DaysEnrollments
    on [Days Enrollments] (DayReservationID)
go

