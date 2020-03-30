create view view_mostActiveDaysParticipants as

select top 2147483647 p.PersonID, p.firstname, p.lastname, stats.number as number
from Persons as p
join dbo.view_personsStats as stats
on p.PersonID = stats.PersonID
where stats.activityType = 'DAYS'
order by number desc
go

