create procedure pr_modifyWorkshopAtConference
    @workAtConfID int,
    @workshopID int = null,
    @dayID int = null,
    @start_time time(7) = null,
    @price money = null,
    @participants_limit int
as
begin
    set nocount on

    if(@workAtConfID not in (select WorkAtConfID from [Workshops At Conferences]))
        throw 52000, 'There is no such workshop', 1

    if(@workshopID is null)
        set @workshopID = (select WorkshopID from [Workshops At Conferences] where WorkAtConfID = @workAtConfID)

    if(@dayID is null)
        set @dayID = (select DayID from [Workshops At Conferences] where WorkAtConfID = @workAtConfID)

    if(@start_time is null)
        set @start_time = (select start_time from [Workshops At Conferences] where WorkAtConfID = @workAtConfID)

    if(@price is null)
        set @price = (select price from [Workshops At Conferences] where WorkAtConfID = @workAtConfID)

    if(@participants_limit is null)
        set @participants_limit = (select participants_limit from [Workshops At Conferences] where WorkAtConfID = @workAtConfID)

    declare @workshop int = (select WorkshopID from Workshops where WorkshopID = @workshopID)
    if (@workshop is null)
        throw 52000, 'There is no such workshop', 1

    declare @day int = (select DayID from Days where DayID = @dayID)
    if (@day is null)
        throw 52000, 'There is no such day', 1

    if(@participants_limit < 0)
        throw 52000, 'Participants limit must be positive', 1

    update [Workshops At Conferences]
    set
        WorkshopID = @workshopID,
        DayID = @dayID,
        start_time = @start_time,
        price = @price,
        participants_limit = @participants_limit
    where WorkAtConfID = @workAtConfID
end
go

