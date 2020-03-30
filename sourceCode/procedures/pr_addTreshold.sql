CREATE procedure pr_addTreshold @conferenceID int,
                                @starts_before int,
                                @ends_before int,
                                @discount real
as
begin
    set nocount on

    declare @conference int = (select ConferenceID from Conferences where ConferenceID = @conferenceID)
    if(@conference is null)
        throw 52000, 'No such conference', 1

    if(not @discount between 0 and 1)
        throw 52000, 'Discount must be between 0 and 1', 1

    if(@starts_before >= @ends_before)
        throw 52000, 'Threshold must start before it ends', 1

    if(@starts_before <=0 or @ends_before <= 0)
        throw 52000, 'Threshold bounds must be positive', 1

    declare @right int = (select top 1 discount from Tresholds where ConferenceID = @conference and @starts_before<starts_before order by discount desc)
    declare @left int = (select top 1 discount from Tresholds where ConferenceID = @conference and @starts_before>starts_before order by discount)

    if(@right is not null)
        if(@discount < @right)
            throw 52000, 'Discounts in thresholds must be descending', 1

    if(@left is not null)
        if(@discount > @left)
        throw 52000, 'Discounts in thresholds must be descending', 1


    insert into Tresholds (ConferenceID, starts_before, ends_before, discount)
    values (@conferenceID, @starts_before, @ends_before, @discount)
end
go

