create view view_customersToCall as
select c.CompanyID, c.company_name, c.email, c.phone, cl.ReservationID, cl.reservationType, cl.reservationObjID
from Companies as c
join dbo.fn_customersToCallIDsList() as cl
on c.CompanyID = cl.CustomerID
go

