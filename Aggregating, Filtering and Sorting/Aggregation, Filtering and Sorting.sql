/*
Intermediate Business Queries
High-Value Inventory Audit: Provide a list of all films where the replacement cost is between 24.00 and 29.99 
and the rental duration is either 3, 5, or 7 days.

Marketing Audience Segmentation: Generate a list of all customers whose first names start with "B" or "K" 
and who are currently assigned to store ID 2.

Revenue Filtering: Identify all individual payments in the payment table that are not 0.99, 2.99, or 4.99.

Content Research: Find all films that contain the word "Astounding" in their description but do not have a rating of "G".

Active Staff Report: List the staff IDs and the total number of transactions handled by each, 
excluding any payments that were exactly 0.00.

Specific Rating Analysis: Return all film titles that have a rating of "NC-17" or "R" 
and have a length that is not between 60 and 90 minutes.

Customer Outreach List: Provide the IDs of all customers who are not active (active = 0) and belong to store ID 1.
*/

SELECT DISTINCT title, replacement_cost, rental_duration FROM film
WHERE (replacement_cost BETWEEN 24.00 AND 29.99)
AND rental_duration IN (3,5,7)

SELECT first_name FROM customer
WHERE (first_name LIKE "B%" OR first_name LIKE "K%")
AND store_id = 2;

SELECT amount FROM payment
WHERE amount NOT IN (0.99, 2.99, 4.99)

SELECT DISTINCT title
FROM film WHERE UPPER(description) LIKE '%ASTOUNDING%'
AND rating != 'G';

SELECT staff_id, COUNT(payment_id) AS num_transactions FROM payment WHERE amount != 0
GROUP BY staff_id;

SELECT title FROM film
WHERE (rating='NC-17' OR 'R')
AND length NOT BETWEEN 60 AND 90;

SELECT customer_id, active, store_id  FROM customer
WHERE active = 0 AND store_id = 1;

/*
Advanced Business Reporting
Store & Staff Performance Matrix (Nested Group By): Calculate the total revenue and the average payment amount, grouped by store ID and then by staff ID.

Global Catalog Sorting (Nested Order By): Extract a full list of films sorted primarily by their rating in alphabetical order, and secondarily by their rental rate from highest to lowest.

Actor Directory (Nested Order By): Generate a list of all actors sorted by their last name in ascending order; for actors with the same last name, sort them by their first name in ascending order.

Tiered Revenue Analysis (Nested Group By): In the payment table, find the maximum and minimum payment amounts, grouped by customer ID and then by the staff member who processed the payment.

Logistics Priority Sort (Nested Order By): List all addresses in the address table. Sort the results first by the district name (A-Z) and then by the postal code in descending order.

Customer Spend Volatility: Calculate the total sum of payments for every customer, but only include individual payments that are between 5.00 and 10.00. Group the final results by customer ID.

Comprehensive Operational Audit (Nested Group & Order By): Calculate the total count of films and the average replacement cost, grouped by rating and then by rental duration. Sort the final output by the average replacement cost in descending order.

*/

SELECT store.store_id AS store,staff.staff_id , SUM(pay.amount) AS total_revenue, AVG(pay.amount) AS average_payment
FROM payment pay
JOIN staff ON staff.staff_id=pay.staff_id
JOIN store ON store.store_id=staff.store_id
GROUP BY 
store.store_id,
staff.staff_id

SELECT * FROM film
ORDER BY rating ASC,
rental_rate DESC;

SELECT first_name, last_name FROM actor
ORDER BY last_name ASC,
first_name ASC;

SELECT customer_id, staff_id, MAX(amount) AS max_payment, MIN(amount) AS min_payment FROM payment
GROUP BY customer_id,
staff_id;

SELECT address, district, postal_code FROM address
ORDER BY
district ASC,
postal_code DESC;

SELECT customer_id,SUM(amount) FROM payment WHERE amount BETWEEN 5.00 AND 10.00
GROUP BY
customer_id;

SELECT COUNT(film_id), AVG(replacement_cost) AS avg_replacementcost FROM film
GROUP BY rating,
rental_duration
ORDER BY avg_replacementcost DESC;