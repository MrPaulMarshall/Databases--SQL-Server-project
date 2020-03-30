create procedure pr_dayParticipants
@dayID int
as
begin
    select p.PersonID, p.firstname, p.lastname, p.phone, p.email
    from Persons as p
    join dbo.fn_dayParticipantIDList(@dayID) as fdp
    on p.PersonID = fdp.PersonID
end
go

