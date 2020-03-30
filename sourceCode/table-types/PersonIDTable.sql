create type PersonIDTable as table
(
    PersonID int,
    unique (
            PersonID)
)
go

