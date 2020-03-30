create procedure pr_workshopParticipants
@workshopID int
as
begin
    select p.PersonID, p.firstname, p.lastname, p.phone, p.email
    from Persons as p
    join dbo.fn_workshopParticipantIDList (@workshopID) as fwp
    on p.PersonID = fwp.PersonID
end
go

