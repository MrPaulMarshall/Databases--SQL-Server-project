create procedure pr_dayParticipantsList
    @dayID int
as
begin
    select P.PersonID, P.firstname, P.lastname
    from Persons P
    join dbo.fn_dayParticipantIDList(@dayID) fdPIL on P.PersonID = fdPIL.PersonID
end
go

