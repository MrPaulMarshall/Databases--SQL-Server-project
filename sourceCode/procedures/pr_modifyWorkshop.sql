create procedure pr_modifyWorkshop
    @workshopID int,
    @name varchar(60) = null,
    @syllabus varchar(256) = null,
    @description varchar(256) = null,
    @price money = null,
    @duration int = null
as
begin
    if (@workshopID not in (select WorkshopID from Workshops))
        throw 52000, 'There is no such workshop', 1

    if (@name is null)
        set @name = (select name from Workshops where WorkshopID = @workshopID)

    if (@syllabus is null)
        set @syllabus = (select syllabus from Workshops)

    if (@duration is null)
        set @duration = (select duration from Workshops where WorkshopID = @workshopID)

    if (@price is null)
        set @price = (select price from Workshops where WorkshopID = @workshopID)

    if (@description is null)
        set @description = (select description from Workshops where WorkshopID = @workshopID)



    update Workshops
    set
        name = @name,
        syllabus = @syllabus,
        duration = @duration,
        price = @price,
        description = @description
    where WorkshopID = @workshopID;
end
go

