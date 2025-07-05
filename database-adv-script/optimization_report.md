# 🚀 Query Optimization Report

## 🎯 Objective

Refactor a complex SQL query that retrieves bookings along with user, property, and payment details to improve query performance and efficiency.

---

## 🔍 Initial Query

The original query joined the `booking`, `users`, `properties`, and `payment` tables to fetch comprehensive booking information.

---

## ⚙️ Refactored Query

The query was optimized by:

- Selecting only necessary columns.
- Filtering bookings to the last year to reduce data volume.
- Ordering results by booking start date in descending order.
- Limiting output to 100 rows for better responsiveness.

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
pay.payment_method
FROM booking b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payment pay ON b.booking_id = pay.booking_id
WHERE b.start_date >= CURRENT_DATE - INTERVAL '1 year'
ORDER BY b.start_date DESC
LIMIT 100;

text

---

## 📈 Performance Enhancements

- Created indexes on key foreign key columns to speed up joins:
  - `booking.user_id`
  - `booking.property_id`
  - `payment.booking_id`
- Reduced execution time by replacing sequential scans with index scans.
- Improved overall query efficiency and user experience by limiting and ordering results.

---

## 💡 Recommendations

- Regularly analyze query plans using `EXPLAIN ANALYZE` to identify bottlenecks.
- Index columns frequently used in joins and filters.
- Limit query result sets when working with large datasets.
- Select only required columns to reduce data transfer and processing.

---

*Report generated on: 2025-07-05*  
Happy optimizing! 🎉
