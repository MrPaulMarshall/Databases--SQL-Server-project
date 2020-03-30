create view view_workshopsOccupancy as
select wac.WorkAtConfID as WorkshopID,
       isnull(
           cast(convert(decimal(2, 0), sum(number_of_bookings))/ convert(decimal(2, 0), avg(participants_limit)) * 100 as varchar),
        '0') as occupancyPercent
from Workshops as w
join [Workshops At Conferences] as wac
on w.WorkshopID = wac.WorkshopID
left outer join [Workshops Reservations] as wr
on wac.WorkAtConfID = wr.WorkAtConfID
group by wac.WorkAtConfID
go

