CREATE procedure pr_addPerson @personID int,
                              @firstname varchar(30),
                              @lastname varchar(30),
                              @email varchar(40),
                              @phone varchar(12),
                              @studentIDNumber int = null
as
begin
    set nocount on

    if(not @email like '%@%.%')
        throw 52000, 'Wrong email format', 1

    if(not isnumeric(@phone) = 1)
        throw 52000, 'Phone number must be numeric', 1

    if(@studentIDNumber is not null)
        if(not isnumeric(@studentIDNumber) = 1)
            throw 50200, 'Student number must be numeric', 1

    insert into Persons (PersonID, firstname, lastname, email, phone, StudentIDNumber)
    values (@personID, @firstname, @lastname, @email, @phone, @studentIDNumber)
end
go

