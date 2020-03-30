CREATE procedure pr_addWorkshopAtConference @workshopID int,
                                            @dayID int,
                                            @start_time time(7),
                                            @price money = null,
                                            @participants_limit int
as
begin
    set nocount on

    if(@price is null)
    begin
        set @price = (select price from Workshops where WorkshopID = @workshopID)
    end

    declare @workshop int = (select WorkshopID from Workshops where WorkshopID = @workshopID)
    if (@workshop is null)
        throw 52000, 'There is no such workshop', 1

    declare @day int = (select DayID from Days where DayID = @dayID)
    if (@day is null)
        throw 52000, 'There is no such day', 1

    if(@participants_limit < 0)
        throw 52000, 'Participants limit must be positive', 1

    insert into [Workshops At Conferences] (WorkshopID, DayID, start_time, price, participants_limit)
    values (@workshopID, @dayID, @start_time, @price, @participants_limit)
end
go

