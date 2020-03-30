CREATE procedure pr_addState @state varchar(40)
as
begin
    set nocount on

    declare @prevState int = (select StateID from States where state = @state)

    if(@prevState is not null)
        throw 52000, 'This state is already in DB', 1

    insert into States (state) values (@state)
end
go

