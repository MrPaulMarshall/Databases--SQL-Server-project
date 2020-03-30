create type StudentIDTable as table
(
    StudentIDNumber int,
    unique (
            StudentIDNumber)
)
go

