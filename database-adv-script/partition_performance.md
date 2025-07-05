# 🚀 Partitioning Performance Report

## 🎯 Objective

Implement range partitioning on the `partition_booking` table based on the `start_date` column to optimize query performance on large datasets.

---

## Implementation Details

- A new `partition_booking` table was created partitioned by range on `start_date`.
- Partitions were created for years 2023, 2024, and 2025.
- Data was migrated from the old table to the new partitioned table.
- Indexes were created on each partition to optimize common queries.

---

## 📊 Performance Testing

### Test Query


