create view view_mostActiveCustomers as

select top 2147483647 *
from (
    select stats.CustomerID, 'COMPANY' as customerType, cmp.company_name as firstname, null as lastname, stats.number
    from dbo.view_customersStats as stats
    join Companies as cmp on stats.CustomerID = cmp.CompanyID

    union

    select stats.CustomerID, 'PRIVATE CUSTOMER' as customerType, p.firstname as firstname, p.lastname as lastname,
           stats.number
    from dbo.view_customersStats as stats
    join [Private Customers] as prc on stats.CustomerID = prc.CustomerID
    join Persons as p on prc.PersonID = p.PersonID
) as nt
order by nt.number desc
go

