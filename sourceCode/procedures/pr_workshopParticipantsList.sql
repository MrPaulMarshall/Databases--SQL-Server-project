create procedure pr_workshopParticipantsList
    @workshopID int
as
begin
    select P.PersonID, P.firstname, P.lastname
    from Persons P
    join dbo.fn_workshopParticipantIDList (@workshopID) fdPIL on P.PersonID = fdPIL.PersonID
end
go

