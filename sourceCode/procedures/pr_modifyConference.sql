create procedure pr_modifyConference
    @conferenceID int,
    @name varchar(60) = null,
    @start_date date = null,
    @duration int = null,
    @stateID int = null,
    @city varchar(40) = null,
    @street varchar(40) = null,
    @description varchar(256) = null,
    @daily_price money = null,
    @daily_limit int = null,
    @student_discount real = null
as
begin
    if (@conferenceID not in (select ConferenceID from Conferences))
        throw 52000, 'There is no such conference', 1

    if (@name is null)
        set @name = (select name from Conferences where ConferenceID = @conferenceID)

    if (@start_date is null)
        set @start_date = (select start_date from Conferences where ConferenceID = @conferenceID)

    if (@duration is null)
        set @duration = (select duration from Conferences where ConferenceID = @conferenceID)

    if (@stateID is null)
        set @stateID = (select StateID from Conferences where ConferenceID = @conferenceID)

    if (@city is null)
        set @city = (select city from Conferences where ConferenceID = @conferenceID)

    if (@street is null)
        set @street = (select street from Conferences where ConferenceID = @conferenceID)

    if (@description is null)
        set @description = (select description from Conferences where ConferenceID = @conferenceID)

    if (@daily_price is null)
        set @daily_price = (select daily_price from Conferences where ConferenceID = @conferenceID)

    if (@daily_limit is null)
        set @daily_limit = (select daily_limit from Conferences where ConferenceID = @conferenceID)

    if (@student_discount is null)
        set @student_discount = (select student_discount from Conferences where ConferenceID = @conferenceID)

    update Conferences
    set
        name = @name,
        start_date = @start_date,
        duration = @duration,
        StateID = @stateID,
        city = @city,
        street = @street,
        description = @description,
        daily_price = @daily_price,
        daily_limit = @daily_limit,
        student_discount = @student_discount
    where ConferenceID = @conferenceID;
end
go

