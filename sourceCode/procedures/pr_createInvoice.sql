create procedure pr_createInvoice
    @reservationID int
    as
    begin
        select dbo.fn_conferenceReservationPrice(@reservationID), c.company_name, c.phone, c.email from Reservations as r inner join Companies as c on r.CustomerID = c.CompanyID where r.ReservationID = @reservationID
    end
go

