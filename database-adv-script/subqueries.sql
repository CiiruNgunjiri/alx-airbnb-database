-- ALX Airbnb Database Module
-- File: subqueries.sql
-- Description: SQL queries demonstrating non-correlated and correlated subqueries on the Airbnb clone database.

-- 1. Non-Correlated Subquery
-- Find all properties where the average rating is greater than 4.0.
-- The subquery calculates average ratings per property independently of the outer query.
SELECT 
    p.property_id, 
    p.name, 
    p.location
FROM properties p
WHERE p.property_id IN (
    SELECT r.property_id
    FROM review r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
);

-- 2. Correlated Subquery
-- Find users who have made more than 3 bookings.
-- The subquery counts bookings for each user by referencing the outer query's user_id.
SELECT 
    u.user_id, 
    u.first_name, 
    u.last_name, 
    u.email
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM booking b
    WHERE b.user_id = u.user_id
) > 3;
