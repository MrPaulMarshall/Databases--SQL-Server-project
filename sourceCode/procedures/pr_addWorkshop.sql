CREATE procedure pr_addWorkshop @name varchar(60),
                                @syllabus varchar(256),
                                @description varchar(256),
                                @price money = 0,
                                @duration int
as
begin
    set nocount on

    if(@price < 0)
        throw 52000, 'This is not a charity', 1

    if(@duration <= 0)
        throw 52000, 'Duration of workshop must be positive', 1

    insert into Workshops (name, syllabus, description, price, duration)
    values (@name, @syllabus, @description, @price, @duration)
end
go

