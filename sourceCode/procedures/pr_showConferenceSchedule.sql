create procedure pr_showConferenceSchedule
    @conferenceID int
as
begin
    select day_of_conference, dateadd(day, day_of_conference, start_date) as date, WorkAtConfID, W.name, start_time,
           W.duration
    from (select * from Conferences where ConferenceID = @conferenceID) as C
    join Days as D on C.ConferenceID = D.ConferenceID
    join [Workshops At Conferences] [W A C] on D.DayID = [W A C].DayID
    join Workshops W on [W A C].WorkshopID = W.WorkshopID
    order by 1, 3, 5, 6
end
go

