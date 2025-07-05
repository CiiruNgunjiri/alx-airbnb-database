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

