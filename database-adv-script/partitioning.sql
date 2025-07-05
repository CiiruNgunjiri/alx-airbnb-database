-- partitioning.sql

-- Step 1: Create the new partitioned booking table
CREATE TABLE partition_booking (
  booking_id UUID PRIMARY KEY,
  user_id UUID NOT NULL,
  property_id UUID NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()
) PARTITION BY RANGE (start_date);

-- Step 2: Create partitions by year (example for 3 years)
CREATE TABLE booking_2023 PARTITION OF booking
  FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE booking_2024 PARTITION OF booking
  FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE booking_2025 PARTITION OF booking
  FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Step 3: Migrate existing data from old table to new partitioned table
INSERT INTO booking (booking_id, user_id, property_id, start_date, end_date, created_at, updated_at)
SELECT booking_id, user_id, property_id, start_date, end_date, created_at, updated_at FROM booking_old;

-- Step 4: (Optional) Drop old booking table after verification
-- DROP TABLE booking;

-- Step 5: Create indexes on partitions (optional but recommended)
CREATE INDEX idx_booking_2023_user_id ON booking_2023(user_id);
CREATE INDEX idx_booking_2024_user_id ON booking_2024(user_id);
CREATE INDEX idx_booking_2025_user_id ON booking_2025(user_id);

-- Similarly, create indexes on other columns as needed

