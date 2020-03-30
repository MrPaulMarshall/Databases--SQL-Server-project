create function fn_workshopParticipantIDList(
    @workshopID int
)
returns table as
return
    select de.PersonID
	from [Workshops At Conferences] as wac
    inner join [Workshops Reservations] as wr
    on wac.WorkAtConfID = wr.WorkAtConfID
    inner join [Workshops Enrollments] as we
    on wr.WorkshopReservationID = we.WorkshopReservationID
	inner join [Days Enrollments] as de
	on we.DayEnrollmentID = de.DayEnrollmentID
    where wac.WorkAtConfID = @workshopID
go

