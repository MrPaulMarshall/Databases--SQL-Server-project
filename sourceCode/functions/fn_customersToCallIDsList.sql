create function fn_customersToCallIDsList()
returns table as
return
    (
        select distinct r.CustomerID, r.ReservationID, 'DAY' as reservationType, dr.DayReservationID as reservationObjID,
                        dbo.fn_freePlacesForDayReservation(dr.DayReservationID) as freePlaces
        from Reservations as r
        join [Days Reservations] dr on r.ReservationID = dr.ReservationID
        where dbo.fn_daysToConference(r.ReservationID) between 0 and 14 and
            dbo.fn_freePlacesForDayReservation(dr.DayReservationID) > 0

        union

        select distinct r.CustomerID, r.ReservationID, 'WORKSHOP' as reservationType, wr.WorkshopReservationID as reservationObjID,
                        dbo.fn_freePlacesForWorkshopReservation(wr.WorkshopReservationID) as freePlaces
        from Reservations as r
        join [Days Reservations] dr on r.ReservationID = dr.ReservationID
        join [Workshops Reservations] wr on dr.DayReservationID = wr.DayReservationID
        where dbo.fn_daysToConference(r.ReservationID) between 0 and 14 and
            dbo.fn_freePlacesForWorkshopReservation(wr.WorkshopReservationID) > 0
    )
go

