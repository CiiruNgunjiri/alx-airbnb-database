-- ALX Airbnb Database Module
-- File: joins_queries.sql
-- Description: SQL queries demonstrating INNER JOIN, LEFT JOIN, and FULL OUTER JOIN on the Airbnb clone database.

-- 1. INNER JOIN
-- Retrieve all bookings along with the users who made those bookings.
-- This query returns only bookings that have a matching user.
SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM booking b
INNER JOIN users u ON b.user_id = u.user_id;


-- 2. LEFT JOIN
-- Retrieve all properties and their reviews, including properties that have no reviews.
-- This query returns all properties; if a property has no reviews, review columns will be NULL.
SELECT 
    p.property_id,
    p.name,
    r.review_id,
    r.rating,
    r.comment
FROM properties p
LEFT JOIN review r ON p.property_id = r.property_id;


-- 3. FULL OUTER JOIN
-- Retrieve all users and all bookings, including users without bookings and bookings not linked to any user.
-- This query returns all users and bookings, with NULLs where there is no match.
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM users u
FULL OUTER JOIN booking b ON u.user_id = b.user_id;

