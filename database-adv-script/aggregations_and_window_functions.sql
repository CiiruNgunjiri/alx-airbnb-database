-- ALX Airbnb Database Module
-- File: aggregation_window.sql
-- Description: SQL queries demonstrating aggregation and window functions on the Airbnb clone database.

-- 1. Total Number of Bookings Made by Each User
-- This query counts the total bookings per user, including users with zero bookings.
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM users u
LEFT JOIN booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;


-- 2. Rank Properties Based on Total Number of Bookings Using RANK()
-- This query ranks properties by the total number of bookings they have received.
SELECT 
    property_id,
    name,
    total_bookings,
    RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank
FROM (
    SELECT 
        p.property_id,
        p.name,
        COUNT(b.booking_id) AS total_bookings
    FROM properties p
    LEFT JOIN booking b ON p.property_id = b.property_id
    GROUP BY p.property_id, p.name
) sub
ORDER BY booking_rank;


-- Optional: Use ROW_NUMBER() for Unique Ranking Without Ties
SELECT 
    property_id,
    name,
    total_bookings,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS booking_rank
FROM (
    SELECT 
        p.property_id,
        p.name,
        COUNT(b.booking_id) AS total_bookings
    FROM properties p
    LEFT JOIN booking b ON p.property_id = b.property_id
    GROUP BY p.property_id, p.name
) sub
ORDER BY booking_rank;

