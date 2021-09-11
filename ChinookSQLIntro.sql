
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

/* select BillingCountry, count(*) [Number of Tracks Purchased]
from Invoice i
	inner join InvoiceLine il -- inner can be implicit and just use join --
		on i.InvoiceId = il.InvoiceId
group by BillingCountry
order by 1 */

-----------------------------------------------------------------------
 -- subqueries --
 -- nesting one or more than one query inside another one --
-- subcategory -- subqueries and correlated subqueries --
-- taking the results from a query and treating them like another table --

-- artists and their longest track with a join subquery-
/* select *
from Artist [Artist]
	join (select ArtistId, max(Milliseconds) [Track Length]
			from Track [Track]
				inner join Album [Album]
					on Track.AlbumId = Track.AlbumId
			group by ArtistId) MaxSong
		on Artist.ArtistId = MaxSong.ArtistId */

-- correlated subquery in the select statement-- 
-- using a piece of information from the outside query in the inside query--
-- why isn't the alias for track length working below?  --

/* select Artist.ArtistId,
		Artist.Name,
		(select max(Milliseconds) [Track Length]
		from Track [Track]
			inner join Album [Album]
				on Track.AlbumId = Track.AlbumId
		where Album.ArtistId = Artist.ArtistId
		group by ArtistId)
from Artist [Artist] */

-- left outer join gives 275 like above, whereas innerjoin got rid of the leftmost in the artist table --
/* select *
from Artist [Artist]
	left outer join (select ArtistId, max(Milliseconds) [Track Length]
			from Track [Track]
				inner join Album [Album]
					on Track.AlbumId = Track.AlbumId
			group by ArtistId) MaxSong
		on Artist.ArtistId = MaxSong.ArtistId */

-- which artists have no tracks? -- 
-- correlated subquery in the where clause --

/* select *
from Artist [Artist]
where not exists (
	select *
	from Track [Track]
		join Album [Album]
			on Album.AlbumId = Track.AlbumId
	where Album.ArtistId = Artist.ArtistId
) */

-- regular subquery -- in operator-- show me all artist where the artist id is not in this set of artist ids-

/* select *
from Artist [Artist]
where ArtistId not in (
	select ArtistId
	from Track [Track]
		join Album [Album]
			on Album.AlbumId = Track.AlbumId
) */

-- unions, except, and union alls --
-- combining two or more result sets that may or may not have anything in common --
-- find the unique things from both lists -- no repeats --
-- the union of the two sets is a set of all the unique items in both sets --
-- union all skips the uniqueness and combines the repeats -- 
-- except will give all the first results set, except where there is a matching result in the second set and a new result in the second set --

/* elect left(Name, 1)
from Artist
union all
select left(FirstName, 1)
from Customer */

-- must have the same number of columns, can be much more complex than below, aliases only matter on the first set--
/* select Email, 'Employee' as [Type]
from Employee
union
select Email, 'Customer'
from Customer */

-- except operator --

/* select ArtistId
from Artist [Artist]
except 
select ArtistId
from Album */

-- intersect gives the middle portion of the venn diagram-- very similar to inner join but would be used for completely unrelated tables--

select ArtistId
from Artist [Artist]
intersect 
select ArtistId
from Album