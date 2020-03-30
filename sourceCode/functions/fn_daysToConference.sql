create function fn_daysToConference(
    @reservationID int
)
returns int as
begin
    return datediff(day, getdate(),
        (select  c.start_date
            from Conferences as c
            where c.ConferenceID = dbo.fn_getReservationConference(@reservationID)
        )
    )
end
go

