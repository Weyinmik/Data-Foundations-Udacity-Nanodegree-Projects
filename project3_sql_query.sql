
#1. Year total sales from 2009 to 2013
SELECT strftime('%Y', it.InvoiceDate) Invoice_Year, count(*) total_sales
FROM InvoiceLine il
JOIN Track t
ON t.TrackId = il.TrackId
JOIN Invoice it
ON il.InvoiceId = it.InvoiceId
GROUP BY Invoice_Year
ORDER BY total_sales DESC;

#2. Country sales level.
SELECT c.Country, SUM(total) total_bill_by_country, 
     CASE WHEN SUM(total) > 300 THEN 'top'
     WHEN  SUM(total) > 100 THEN 'middle'
     ELSE 'low' END AS country_sales_level
FROM Invoice i
JOIN Customer c
ON i.CustomerId  = c.CustomerId 
GROUP BY c.Country
ORDER BY 2 DESC;

#3 How many Customer accounts are managed by each Sales support Agent at Chinook Music.
SELECT e.EmployeeId, e.FirstName, e.Title, COUNT(*) num_customer_accounts
FROM Customer c
JOIN Employee e
ON e.EmployeeId = c.SupportRepId
GROUP BY e.EmployeeId, e.FirstName
ORDER BY num_customer_accounts;



#4. The sales rep that made the most transaction
SELECT e.FirstName sales_rep_name,  SUM(i.Total) total_amt
FROM Employee e
JOIN Customer c
ON c.SupportRepId = e.EmployeeId
JOIN Invoice i
ON i.CustomerId = c.CustomerId
GROUP BY 1
ORDER BY 2 DESC;
#5 Customers that purchsed Rock Genre of Music
SELECT c.Email, c.FirstName,c.LastName, g.Name
FROM Customer c
JOIN Invoice i
ON i.CustomerId = c.CustomerId
JOIN InvoiceLine il
ON i.InvoiceId = il.InvoiceId
JOIN Track t
ON t.TrackId = il.TrackId
JOIN Genre g
ON g.GenreId = t.GenreId
WHERE g.Name = 'Rock'
GROUP BY 1
ORDER BY 4 DESC;

#6 Customer whose email address start with a and listen to Rock Music

SELECT c.Email, c.FirstName,c.LastName, g.Name
FROM Customer c
JOIN Invoice i
ON i.CustomerId = c.CustomerId
JOIN InvoiceLine il
ON i.InvoiceId = il.InvoiceId
JOIN Track t
ON t.TrackId = il.TrackId
JOIN Genre g
ON g.GenreId = t.GenreId
WHERE g.Name = 'Rock' AND Email LIKE 'a%'
GROUP BY 1
ORDER BY 4 DESC;

#7 The Amount of different genre sale in each country
SELECT DISTINCT g.Name, c.Country, COUNT(g.Name) numb_genre_purchased
FROM Customer c
JOIN Invoice i
ON i.CustomerId = c.CustomerId
JOIN InvoiceLine il
ON i.InvoiceId = il.InvoiceId
JOIN Track t
ON t.TrackId = il.TrackId
JOIN Genre g
ON g.GenreId = t.GenreId
GROUP BY 2
ORDER BY 3 DESC;

#8. Top 10 Artist in the Rock Genre and the number of songs on eack albulm
SELECT ar.ArtistId, ar.Name ArtistName, COUNT(t.Name) Song_count
FROM Track t
JOIN Album a
ON a.AlbumId = t.AlbumId
JOIN Artist ar
ON ar.ArtistId = a.ArtistId
JOIN Genre g
ON g.GenreId = t.GenreId
WHERE g.Name = 'Rock'
GROUP BY 1
ORDER BY 3 DESC
LIMIT 10;