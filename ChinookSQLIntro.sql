
-- comment out with dashes on one line --
/*muliple lines*/ 

-- what artists' music do we sell?--
-- give me data from artist table--
-- what should it look like?--
-- that's with select/ transforming data-- 
--select Name --
-- select star gets all the data --
-- filtering with where / which artists' music do we sell that starts with c? --
-- select *, ArtistId + 100000 --
--from  Artist --
-- not case sensitive --
-- blocking [] avoids tsql recognizing as keyword --
--where [Name] = 'AC/DC'--
-- like is matching a pattern and is generally used with wild card characters--
-- says show all artists that start with c and are followed by a number of characters after--
-- query-- planned execution will show step by step how it works with info on operating costs--
-- where [Name] like 'c%' --

-- which states are our customer located in? --
/*select [State]
from Customer
where [State] != 'NULL'*/

-- count is an aggregate function-- 
-- only aggregate functions on same line, need group by clause with nonaggregate function --
/*select count(*), [State]
from Customer
where [State] != 'Null' group by [State]*/

/* select [State], count(*), string_agg(FirstName, ',')
from Customer
where [State] != 'Null' group by [State] */

-- giving column names with as or =  "" or just brackets --
-- aliasing is what that is called --
/* select [State] [Customer State],
		count(*) [Number of Customers],
		string_agg(FirstName, ',') as [First Name]
from Customer */

/* select isnull ([State], Country) as [Customer Location],
		count(*) [Number of Customers],
		string_agg(FirstName, ',') as [First Name]
from Customer
-- works same way as below--
-- group by [State], Country --
group by isnull([State], Country) */

-- null is a special thing, you have to use is null and is not null to compare it to things --
/* select *
from Customer
where [State] is not null */

-- how many music tracks were purchased by each customer country? --
-- data from two different places --

/*select *
from Invoice -- cusotmer id and billing country -- */


/* select *
from InvoiceLine -- traks on the invoice -- */

-- combine --

select BillingCountry, count(*) [Number of Tracks Purchased]
from Invoice i
	inner join InvoiceLine il -- inner can be implicit and just use join --
		on i.InvoiceId = il.InvoiceId
group by BillingCountry
order by 1