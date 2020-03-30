create view view_mostPopularWorkshops as
select top 2147483647 *
from (
    select W.WorkshopID, W.name, count(*) counter
    from [Workshops Enrollments] WE
    join [Workshops Reservations] [W R] on WE.WorkshopReservationID = [W R].WorkshopReservationID
    join [Workshops At Conferences] on [W R].WorkAtConfID = [Workshops At Conferences].WorkAtConfID
    join Workshops W on [Workshops At Conferences].WorkshopID = W.WorkshopID
    group by W.WorkshopID, W.name
) as NT
order by NT.counter desc
go

