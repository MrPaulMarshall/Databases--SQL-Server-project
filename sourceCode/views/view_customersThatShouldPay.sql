create view view_customersThatShouldPay as

select ctsp.CustomerID, 'COMPANY' as customerType, cmp.company_name as firstname, null as lastname, cmp.email,
       cmp.phone, ctsp.ReservationID, ctsp.ConferenceID, ctsp.days_since_reservation
from dbo.fn_customersThatShouldPay() as ctsp
join Companies as cmp on ctsp.CustomerID = cmp.CompanyID

union

select ctsp.CustomerID, 'PRIVATE CUSTOMER' as customerType, p.firstname as firstname, p.lastname as lastname, p.email,
       p.phone, ctsp.ReservationID, ctsp.ConferenceID, ctsp.days_since_reservation
from dbo.fn_customersThatShouldPay() as ctsp
join [Private Customers] as prc on ctsp.CustomerID = prc.CustomerID
join Persons as p on prc.PersonID = p.PersonID
go

