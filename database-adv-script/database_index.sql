-- ALX Airbnb Database Module
-- File: database_index.sql
-- Description: Create indexes on high-usage columns to improve query performance.

-- Indexes on Users table
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- Indexes on Booking table
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON booking(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON booking(property_id);
CREATE INDEX IF NOT EXISTS idx_booking_start_date ON booking(start_date);
CREATE INDEX IF NOT EXISTS idx_booking_end_date ON booking(end_date);

-- Indexes on Properties table
CREATE INDEX IF NOT EXISTS idx_properties_host_id ON properties(host_id);
CREATE INDEX IF NOT EXISTS idx_properties_location ON properties(location);
CREATE INDEX IF NOT EXISTS idx_properties_price ON properties(price);

-- Optional composite index for frequent combined queries on booking by user and date
CREATE INDEX IF NOT EXISTS idx_booking_user_start_date ON booking(user_id, start_date);

-- -------------------------------------------------------------------
-- To measure query performance BEFORE creating indexes, run:

-- EXPLAIN ANALYZE
-- SELECT * FROM booking WHERE user_id = '9e9490ab-e46b-4565-ab3b-1231412051d8';

-- -------------------------------------------------------------------
-- To measure query performance AFTER creating indexes, run:

-- EXPLAIN ANALYZE
-- SELECT * FROM booking WHERE user_id = '9e9490ab-e46b-4565-ab3b-1231412051d8';

-- -------------------------------------------------------------------
-- Similarly, test other queries like joins or ordering by price_per_night:

-- EXPLAIN ANALYZE
-- SELECT p.property_id, p.name, p.location, p.price_per_night
-- FROM properties p
-- JOIN booking b ON p.property_id = b.property_id
-- WHERE b.user_id = '9e9490ab-e46b-4565-ab3b-1231412051d8'
-- ORDER BY p.price_per_night ASC;


