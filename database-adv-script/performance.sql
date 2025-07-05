-- perfomance.sql

-- Initial query: Retrieve all bookings with user, property, and payment details

SELECT
  b.booking_id,
  b.start_date,
  b.end_date,
  u.user_id,
  u.first_name,
  u.last_name,
  u.email,
  p.property_id,
  p.name AS property_name,
  p.location,
  p.price_per_night,
  pay.payment_id,
  pay.amount,
  pay.payment_date,
  pay.status AS payment_status
FROM booking b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payment pay ON b.booking_id = pay.booking_id;

-- -------------------------------------------------------------------
-- To analyze performance BEFORE creating indexes, run:

-- EXPLAIN ANALYZE
-- SELECT
--   b.booking_id,
--   b.start_date,
--   b.end_date,
--   u.user_id,
--   u.first_name,
--   u.last_name,
--   u.email,
--   p.property_id,
--   p.name AS property_name,
--   p.location,
--   p.price_per_night,
--   pay.payment_id,
--   pay.amount,
--   pay.payment_date,
--   pay.status AS payment_status
-- FROM booking b
-- JOIN users u ON b.user_id = u.user_id
-- JOIN properties p ON b.property_id = p.property_id
-- LEFT JOIN payment pay ON b.booking_id = pay.booking_id;

-- -------------------------------------------------------------------
-- Refactored query with filtering, ordering, and limit for better performance

SELECT
  b.booking_id,
  b.start_date,
  b.end_date,
  u.user_id,
  u.first_name,
  u.last_name,
  u.email,
  p.property_id,
  p.name AS property_name,
  p.location,
  p.price_per_night,
  pay.payment_id,
  pay.amount,
  pay.payment_date,
  pay.status AS payment_status
FROM booking b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payment pay ON b.booking_id = pay.booking_id
WHERE b.start_date >= CURRENT_DATE - INTERVAL '1 year'
ORDER BY b.start_date DESC
LIMIT 100;

-- -------------------------------------------------------------------
-- To analyze performance AFTER creating indexes, run the above EXPLAIN ANALYZE query again.

