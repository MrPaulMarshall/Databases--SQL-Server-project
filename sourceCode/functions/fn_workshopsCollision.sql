create function fn_workshopsCollision (
    @workshopID1 int,
    @workshopID2 int
)
returns bit
as
begin
    declare @startTime1 time(7);
    declare @endTime1 time(7);
    declare @date1 date;

    declare @startTime2 time(7);
    declare @endTime2 time(7);
    declare @date2 date;

    set @startTime1 = (select start_time from [Workshops At Conferences] where WorkAtConfID = @workshopID1)
    set @endTime1 = dateadd(minute, (
        select w.duration
        from [Workshops At Conferences] as wac
        join Workshops as w on wac.WorkshopID = w.WorkshopID
        where WorkAtConfID = @workshopID1
    ), @startTime1 )
    set @date1 = (
        select dateadd(day, d.day_of_conference, c.start_date)
        from Conferences as c
        join Days as d on d.conferenceID = c.conferenceID
        join [Workshops At Conferences] as w on w.dayID = d.dayID
        where w.workshopID = @workshopID1
    )

    set @startTime2 = (select start_time from [Workshops At Conferences] where WorkAtConfID = @workshopID2)
    set @endTime2 = dateadd(minute, (
        select w.duration
        from [Workshops At Conferences] as wac
        join Workshops as w on wac.WorkshopID = w.WorkshopID
        where WorkAtConfID = @workshopID2
    ), @startTime2 )
    set @date2 = (
        select dateadd(day, d.day_of_conference, c.start_date)
        from Conferences as c
        join Days as d on d.conferenceID = c.conferenceID
        join [Workshops At Conferences] as w on w.dayID = d.dayID
        where w.workshopID = @workshopID2
    )

    declare @collision bit;
    if ((@date1 <> @date2) or (@startTime1 > @endTime2 or @startTime2 > @endTime1))
        set @collision = 0
    else
        set @collision = 1

    return @collision
end
go

