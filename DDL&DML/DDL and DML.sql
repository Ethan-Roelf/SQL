/*
BEGINNER QUERIES
*/


/*
New Service Launch: The marketing team wants to track customer loyalty points. Create a new table 
named customer_loyalty with three columns: customer_id (integer), points (integer), and tier (string).
*/

CREATE TABLE customer_loyalty(
    customer_id INT,
    points INT,
    tier VARCHAR(255)
);

/*
Actor Onboarding: A new actor named "GENE CASSIDY" has joined a production. Add this actor to the existing system.
*/

INSERT INTO actor(first_name, last_name)
VALUES(
    'Gene','Cassidy'
);

/*
A customer with ID 12 has moved. Change their email address to PATRICIA.JOHNSON@newdomain.com in the database.
*/

UPDATE customer
SET email = 'PATRICIA.JOHNSON@newdomain.com' WHERE customer_id = 12;

/*
The business decided to remove a staff member with ID 2 from the system entirely. Perform the necessary 
operation to remove this record from the staff table.
*/

DELETE FROM staff
WHERE staff_id=2;

/*
You are tasked with clearing out all records from the payment table for a test environment reset, 
but you must keep the table structure intact for future use.
*/

TRUNCATE TABLE payment;

/*
INTERMEDIATE QUERIES
*/

/*
Schema Expansion: To support a new mobile app feature, add a column named phone_verified 
(boolean/tinyint) to the existing customer table. Set the default value to 0.
*/

ALTER TABLE customer
ADD COLUMN phone_verified BOOLEAN
DEFAULT = 0;

/*
Bulk Inventory Arrival: The store received a shipment of 5 new copies of the film with ID 1 for Store ID 2. 
Add these 5 individual records to the inventory table in a single operation.
*/

INSERT INTO inventory(film_id, store_id)
VALUES
(1,2),
(1,2),
(1,2),
(1,2),
(1,2);

/*
The company is increasing all rental rates by 10% for films currently rated "G". Update the film table accordingly.
*/

UPDATE film
SET rental_rate = rental_rate*1.10
WHERE rating = 'G';

/*
The legal department requires a copy of the actor table for auditing purposes. Create a new table 
named actor_audit that has the exact same structure as the actor table, including all data
*/

CREATE TABLE actor_audit
AS
SELECT * FROM actor;

/*
Modify the address table to ensure that the postal_code column can no longer accept NULL values.
*/
ALTER TABLE address
MODIFY postal_code VARCHAR(10) NOT NULL;

/*
HIGHER LEVEL QUERIES
*/

/*
You are syncing data from an external source. Write a statement to add a new record to the language table for "Mandarin". 
If the language ID already exists, update the name of that specific record to "Mandarin-CN" instead.
*/

INSERT INTO language(language_id, name)
VALUES(10,'Mandarin')
ON DUPLICATE KEY UPDATE name = 'Mandarin-CN';

/*Create a table named inactive_customers_archive. Move (Insert and then Delete) all customers from the customer 
table who have an active status of 0 into this new archive table.
*/

CREATE TABLE inactive_customers_archive AS
customer
WHERE 1=0;

INSERT INTO inactive_customers_archive
SELECT * FROM customer WHERE active = 0;

DELETE FROM customer
WHERE active = 0;

/*
The product manager wants to change the description column in the film table from a TEXT type to a VARCHAR(500) 
and simultaneously rename it to film_summary.
*/

ALTER TABLE film
CHANGE COLUMN description film_summary VARCHAR(500)

/*
The business is deleting all categories that do not have any films associated with them. 
Write an operation to remove these specific categories from the category table.
*/

DELETE FROM category
WHERE
category_id NOT IN (SELECT DISTINCT category_id FROM film_category)