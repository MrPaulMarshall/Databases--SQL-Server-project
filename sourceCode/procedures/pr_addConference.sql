CREATE procedure pr_addConference @name varchar(60),
                                  @start_date date,
                                  @duration int,
                                  @stateID int,
                                  @city varchar(40),
                                  @street varchar(40),
                                  @description varchar(256),
                                  @daily_price money,
                                  @daily_limit int,
                                  @student_discount real
as
begin
    set nocount on

    if(not @student_discount between 0 and 1)
        throw 52000, 'Student discount must be between 0 and 1', 1

    if(@duration < 0)
        throw 52000, 'Duration must be non negative', 1

    declare @state int = (select StateID from States where StateID = @stateID)
    if(@state is null)
        throw 52000, 'State non existent', 1

    if(@daily_price < 0)
        throw 52000, 'Price is negative, this in not a charity', 1

    if(@daily_limit <= 0)
        throw 52000, 'Participants limit is negative', 1

    insert into Conferences (name, start_date, duration, StateID, city, street, description, daily_price, daily_limit,
                             student_discount)
        values (@name, @start_date, @duration, @stateID, @city, @street, @description, @daily_price, @daily_limit,
            @student_discount)

    declare @conferenceID int = (select max(ConferenceID) from Conferences)

    -- pętla która generuje dni nowej konferencji
    declare @iterator int = 0
    while (@iterator < @duration) begin
        exec dbo.pr_addDay @conferenceID = @conferenceID, @day_of_conference = @iterator

        set @iterator = @iterator + 1
    end
end
go

