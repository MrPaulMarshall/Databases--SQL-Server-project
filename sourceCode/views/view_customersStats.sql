create view view_customersStats as

select c.CustomerID, count(*) as number
from Customers as c
join Reservations as r on c.CustomerID = r.CustomerID
group by c.CustomerID
go

