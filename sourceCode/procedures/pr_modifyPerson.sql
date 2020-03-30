create procedure pr_modifyPerson
    @personID int,
    @firstname varchar(30) = null,
    @lastname varchar(30) = null,
    @email varchar(40) = null,
    @phone varchar(12) = null,
    @studentIDNumber int = null
as
begin
    set nocount on

    if (@personID not in (select PersonID from Persons))
        throw 52000, 'There is no person with this ID', 1

    if (@firstname is null)
        set @firstname = (select firstname from Persons)

    if (@lastname is null)
        set @lastname = (select lastname from Persons)

    if (@email is null)
        set @phone = (select phone from Persons)

    if (@studentIDNumber is null)
        set @studentIDNumber = (select StudentIDNumber from Persons)

    if(not @email like '%@%.%')
        throw 52000, 'Wrong email format', 1

    if(not isnumeric(@phone) = 1)
        throw 52000, 'Phone number must be numeric', 1

    if(@studentIDNumber is not null)
        if(not isnumeric(@studentIDNumber) = 1)
            throw 50200, 'Student number must be numeric', 1

    update Persons
    set
        firstname = @firstname,
        lastname = @lastname,
        email = @email,
        phone = @phone,
        StudentIDNumber = @studentIDNumber
    where PersonID = @personID
end
go

