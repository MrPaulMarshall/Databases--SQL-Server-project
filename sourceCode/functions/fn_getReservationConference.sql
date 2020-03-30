create function fn_getReservationConference(
    @reservationID int
)
returns int
as
begin
    declare @conferenceID int
    set @conferenceID = (
        select d.ConferenceID
        from Days as d
        join (
            select top 1 DayID
            from [Days Reservations] as dr
            where dr.ReservationID = @reservationID
        ) as dr_top
        on d.DayID = dr_top.DayID
    )

    return @conferenceID
end
go

