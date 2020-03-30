create function fn_dayParticipantIDList(
    @dayID int
)
returns table as
return
    select de.PersonID
	from Days as d
    inner join [Days Reservations] as dr
    on d.DayID = dr.DayID
    inner join [Days Enrollments] as de
    on dr.DayReservationID = de.DayReservationID
    where d.DayID = @dayID
go

