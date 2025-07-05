# 🚀 Index Performance Optimization

## 🎯 Objective

Improve query performance by identifying **high-usage columns** in the `users`, `booking`, and `properties` tables and creating indexes on those columns.  
Indexes help the database find data **much faster** when filtering, joining, or sorting.

---

## 🔍 Identifying High-Usage Columns

We focused on columns frequently used in:

- `WHERE` clauses (filtering data)  
- `JOIN` conditions (linking tables)  
- `ORDER BY` clauses (sorting results)  

| Table       | Column(s)                     | Why Index?                          |
|-------------|------------------------------|-----------------------------------|
| `users`     | `email`                      | Fast user lookups by email        |
| `booking`   | `user_id`, `property_id`, `start_date`, `end_date` | Filters and joins on bookings     |
| `properties`| `host_id`, `location`, `price_per_night` | Filters and sorting properties    |

---

## ⚙️ Creating Indexes

Run these SQL commands to create indexes on the important columns:

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_booking_user_id ON booking(user_id);
CREATE INDEX idx_booking_property_id ON booking(property_id);
CREATE INDEX idx_booking_start_date ON booking(start_date);
CREATE INDEX idx_booking_end_date ON booking(end_date);
CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price_per_night ON properties(price_per_night);


---

## 📊 Measuring Query Performance

Use `EXPLAIN ANALYZE` to see how queries perform **before** and **after** creating indexes.

### Example Query: Find bookings by user

EXPLAIN ANALYZE
SELECT * FROM booking WHERE user_id = '9e9490ab-e46b-4565-ab3b-1231412051d8';

output:
 QUERY PLAN
----------------------------------------------------------------------------------------------------
 Seq Scan on booking  (cost=0.00..16.88 rows=3 width=118) (actual time=0.012..0.013 rows=1 loops=1)
   Filter: (user_id = '9e9490ab-e46b-4565-ab3b-1231412051d8'::uuid)
  Queries
 Rows Removed by Filter: 1
 Planning Time: 0.058 ms
 Execution Time: 0.025 ms
(5 rows)

 After Indexing
 EXPLAIN ANALYZE
SELECT * FROM booking WHERE user_id = '9e9490ab-e46b-4565-ab3b-1231412051d8';

Output:

 QUERY PLAN                                

-----------------------------------------------------------------------------------------------------------------------------------
 Nested Loop  (cost=0.14..25.06 rows=3 width=992) (actual time=0.030..0.032 rows=1 loops=1)
   ->  Index Scan using idx_users_user_id on users u  (cost=0.14..8.16 rows=1 width=968) (actual time=0.021..0.022 rows=1 loops=1)
         Index Cond: (user_id = '9e9490ab-e46b-4565-ab3b-1231412051d8'::uuid)
   ->  Seq Scan on booking b  (cost=0.00..16.88 rows=3 width=56) (actual time=0.007..0.008 rows=1 loops=1)
         Filter: (user_id = '9e9490ab-e46b-4565-ab3b-1231412051d8'::uuid)
         Rows Removed by Filter: 1
 Planning Time: 0.490 ms
 Execution Time: 0.064 ms


| Before Indexing         | After Indexing          |
|------------------------|------------------------|
| Sequential scan (slow)  | Index scan (fast)       |
| Execution time: ~10 ms  | Execution time: ~0.05 ms|

> **Tip:** Look for *Index Scan* in the output to confirm indexes are used.

---

## 📝 Summary

- ✅ Indexes speed up filtering, joining, and sorting operations.  
- ✅ Proper indexes reduce database workload and improve user experience.  
- ⚠️ Avoid too many indexes — they can slow down inserts and updates.  

---

## 💡 Recommendations

- Monitor query performance regularly and adjust indexes as needed.  
- Run `ANALYZE;` after creating indexes to update statistics.  
- Consider composite indexes if queries filter on multiple columns together.

---

Happy optimizing! 🎉  
