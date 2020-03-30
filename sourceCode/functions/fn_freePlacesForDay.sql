CREATE function [dbo].[fn_freePlacesForDay](@dayID int)
returns int
as
begin
	declare @totalPlaces int
	set @totalPlaces = (
		select c.daily_limit
		from Conferences as c
		join Days as d on c.ConferenceID = d.ConferenceID
		where d.DayID = @dayID
	)

	declare @takenPlaces int
	set @takenPlaces = (
		select SUM(dr.number_of_bookings)
		from [Days Reservations] AS dr
		where dr.DayID = @dayID
	)

	return (@totalPlaces - @takenPlaces);
end
go

