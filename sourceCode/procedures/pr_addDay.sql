CREATE procedure pr_addDay @conferenceID int,
                           @day_of_conference int
as
begin
    set nocount on

    declare @Conference int = (select ConferenceID from Conferences where @conferenceID = ConferenceID)
    if(@Conference is null)
        throw 52000, 'There is no such conference',1

    declare @AnotherDay int = (select DayID from Days where ConferenceID = @conferenceID and day_of_conference = @day_of_conference)
    if(@AnotherDay is not null)
        throw 52000, 'This day already exists',1

    if(@day_of_conference < 0)
        throw 52000, 'Day number must be positive', 1

    declare @Days int = (select duration from Conferences where ConferenceID = @Conference)
    if(@day_of_conference >= @Days)
        throw 52000, 'The day is after the conference', 1

    insert into Days (ConferenceID, day_of_conference) values (@conferenceID, @day_of_conference)
end
go

