CREATE procedure pr_customersThatShouldPay
    @days_to_deletion int
as
begin
    if (@days_to_deletion not between 0 and 7)
    begin
        throw 52000, 'Please give reasonable number of days, in range [0..7]', 1
    end

    select *
    from dbo.view_customersThatShouldPay
    where 7 - days_since_reservation <= @days_to_deletion
end
go

