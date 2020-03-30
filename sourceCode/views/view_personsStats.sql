create view view_personsStats as

select p.PersonID, 'DAYS' as activityType, count(de.DayEnrollmentID) as 'number'
from Persons as p
left outer join [Days Enrollments] as de
on de.PersonID = p.PersonID
left outer join [Days Reservations] as dr
on dr.DayReservationID = de.DayReservationID
group by p.PersonID

union

select p.PersonID, 'WORKSHOPS' as activityType, count(we.WorkshopEnrollmentID) as 'number'
from Persons as p
left outer join [Days Enrollments] as de
on de.PersonID = p.PersonID
left outer join [Workshops Enrollments] as we
on we.DayEnrollmentID = de.DayEnrollmentID
left outer join [Workshops Reservations] as wb
on wb.WorkshopReservationID = we.WorkshopReservationID
left outer join [Days Reservations] as dr
on dr.DayReservationID = de.DayReservationID
group by p.PersonID
go

