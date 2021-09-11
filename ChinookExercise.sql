-- Provide a query showing Customers (just their full names, customer ID and country) who are not in the US. --

/* select *
from Customer
where Country != 'USA' */

-- Provide a query only showing the Customers from Brazil. --

/*select *
from Customer
where Country = 'Brazil' */

/* Provide a query showing the Invoices of customers who are from Brazil.
The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country. */

/* select Invoice.CustomerId, InvoiceId, InvoiceDate, BillingCountry, FirstName, LastName -- not really understanding why FN LN is accessible here--
from Invoice
join Customer on Customer.CustomerId = Invoice.CustomerId
where BillingCountry = 'Brazil' */

-- Provide a query showing only the Employees who are Sales Agents. --

/* select *
from Employee
where Employee.Title = 'Sales Support Agent' */

-- Provide a query showing a unique/distinct list of billing countries from the Invoice table. --

/* select BillingCountry, count(*) as [Invoices]
from Invoice
group by BillingCountry */

/* Provide a query that shows the invoices associated with each sales agent.
The resultant table should include the Sales Agent's full name. */

-- how would I group this by employee id and hide repeat info in support rep id --
/* select
	EmployeeId,
	Employee.FirstName,
	Employee.LastName,
	SupportRepId,
	Customer.CustomerId,
	Invoice.InvoiceId
from Employee
	join Customer on Customer.SupportRepId = Employee.EmployeeId
	join Invoice on Invoice.CustomerId = Customer.CustomerId */

-- Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.--

/* select FirstName, LastName, SupportRepId,Total, Country
from Customer
join Invoice on Customer.CustomerId = Invoice.CustomerId */

-- How many Invoices were there in 2009 and 2011? --

/* select
    count(case when InvoiceDate between '2009-01-01 00:00:00:000' and '2009-12-31 00:00:00:000' then 1
        else null end) [Number of Invoices in 2009],
    count(case when InvoiceDate between '2011-01-01 00:00:00:000' AND '2011-12-31 00:00:00:000' then 1
        else null end) [Number of Invoices in 2011]
from Invoice */

-- What are the respective total sales for each of those years? --

/* select
    sum(case when InvoiceDate between '2009-01-01 00:00:00:000' and '2009-12-31 00:00:00:000' then Invoice.Total
        else 0 end) [Total Sales for 2009],
    sum(case when InvoiceDate between '2011-01-01 00:00:00:000' and '2011-12-31 00:00:00:000' then Invoice.Total
        else 0 end) [Total Sales for 2011]
from Invoice */

-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.--

/* select count(*) [Number of Line Items for Invoice Id 37]
from InvoiceLine
where InvoiceId = '37' */

-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY --

/* select count(*) [Number of Line Items for each Invoice]
from InvoiceLine
group by InvoiceId */

-- Provide a query that includes the purchased track name with each invoice line item. --

/* select InvoiceId, InvoiceLine.TrackId, Track.Name
from InvoiceLine
	join Track on Track.TrackId = InvoiceLine.TrackId
order by InvoiceId */

-- Provide a query that includes the purchased track name AND artist name with each invoice line item. --

/* select InvoiceId, InvoiceLine.TrackId, Track.Name, Track.Composer
from InvoiceLine
	join Track on Track.TrackId = InvoiceLine.TrackId
	where Composer != 'Null'
order by InvoiceId */

-- Provide a query that shows the # of invoices per country. HINT: GROUP BY -- 

/* select count(InvoiceId) [Number of Invoices], BillingCountry
from Invoice
group by BillingCountry */

/* Provide a query that shows the total number of tracks in each playlist. 
The Playlist name should be include on the resultant table. */


/* select Playlist.Name, count(TrackId) [Number of Tracks]
from Playlist
	join PlaylistTrack on Playlist.PlaylistId = PlaylistTrack.PlaylistId
group by Playlist.Name */

-- Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.--

/* select Track.Name, Title, MediaType.Name, Genre.Name
from Track
	join Album on Album.AlbumId = Track.AlbumId
	join MediaType on MediaType.MediaTypeId = Track.MediaTypeId
	join Genre on Genre.GenreId = Track.GenreId */

-- Provide a query that shows all Invoices but includes the # of invoice line items. --

/* select count(*) [Number of Invoice Line Items]
from InvoiceLine
group by InvoiceId */

-- Provide a query that shows total sales made by each sales agent. --

/* select Employee.FirstName, Employee.LastName, sum(Total) [Total Sales]
from Invoice
	join Customer on Customer.CustomerId = Invoice.CustomerId
	join Employee on Employee.EmployeeId = Customer.SupportRepId
group by Employee.FirstName, Employee.LastName */

-- Which sales agent made the most in sales in 2009? HINT: TOP --

/* select TOP(1)
	Employee.FirstName,
	Employee.LastName,
	sum(case when InvoiceDate between '2009-01-01 00:00:00:000' AND '2009-12-31 00:00:00:000' then Total else 0 end) [Total Sales]
from Invoice
	join Customer on Customer.CustomerId = Invoice.CustomerId
	join Employee on Employee.EmployeeId = Customer.SupportRepId
group by Employee.FirstName, Employee.LastName
order by [Total Sales] DESC */

-- Which sales agent made the most in sales over all? --

/* select TOP(1) Employee.FirstName, Employee.LastName, sum(Total) [Total Sales]
from Invoice
	join Customer on Customer.CustomerId = Invoice.CustomerId
	join Employee on Employee.EmployeeId = Customer.SupportRepId
group by Employee.FirstName, Employee.LastName
order by [Total Sales] DESC */

-- Provide a query that shows the count of customers assigned to each sales agent. --

/* select count(CustomerId) [Number of Customers], Employee.FirstName, Employee.LastName
from Customer
	join Employee on Employee.EmployeeId = Customer.SupportRepId
group by SupportRepId, Employee.FirstName, Employee.LastName
order by [Number of Customers] DESC */ 

-- Provide a query that shows the total sales per country --

/* select BillingCountry, sum(Total) [Total Sales]
from Invoice
group by BillingCountry */

-- Which country's customers spent the most? --

/* select TOP(1) BillingCountry, sum(Total) [Total Sales]
from Invoice
group by BillingCountry
order by [Total Sales] DESC */

-- Provide a query that shows the most purchased track of 2013. --

/* select TOP(14) sum(case when InvoiceDate between '2013-01-01 00:00:00:000' AND '2013-12-31 00:00:00:000' then Total else 0 end) [Total Sales in 2013], Track.Name
from Invoice
	join InvoiceLine on InvoiceLine.InvoiceId = Invoice.Invoiceid
	join Track on Track.TrackId = InvoiceLine.TrackId
group by Track.TrackId, Track.Name
order by [Total Sales in 2013] DESC */

-- Provide a query that shows the top 5 most purchased songs. --

/* select TOP(5) sum(Total) [Total Sales], Track.Name [Most Purchased Songs]
from Invoice
	join InvoiceLine on InvoiceLine.InvoiceId = Invoice.InvoiceId
	join Track on Track.TrackId = InvoiceLine.TrackId
group by Track.Name
order by [Total Sales] DESC */

-- Provide a query that shows the top 3 best selling artists. --

/* select TOP(3) sum(Total) [Total Sales], Artist.Name [Top Selling Artists]
from Invoice
	join InvoiceLine on InvoiceLine.InvoiceId = Invoice.InvoiceId
	join Track on Track.TrackId = InvoiceLine.TrackId
	join Album on Album.AlbumId = Track.AlbumId
	join Artist on Artist.ArtistId = Album.AlbumId
group by Artist.Name
order by [Total Sales] DESC */

-- Provide a query that shows the most purchased Media Type. --

/* select TOP(1) sum(Total) [Total Sales], MediaType.Name [Top Selling Media Type]
from Invoice
	join InvoiceLine on InvoiceLine.InvoiceId = Invoice.InvoiceId
	join Track on Track.TrackId = InvoiceLine.TrackId
	join MediaType on MediaType.MediaTypeId = Track.MediaTypeId
group by MediaType.Name
order by [Total Sales] DESC */
