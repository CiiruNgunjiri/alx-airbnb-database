# ALX Airbnb Database Module — Advanced SQL Queries

Welcome to the **ALX Airbnb Database Module** project! This repository contains SQL queries demonstrating advanced join and subquery operations on a simulated Airbnb database.

---

## 📚 Project Overview

This project focuses on mastering **advanced SQL querying techniques** to extract meaningful insights by combining data from multiple related tables. You will write queries using:

- **INNER JOIN**: Retrieve records with matching values in both tables.
- **LEFT JOIN**: Retrieve all records from the left table and matched records from the right.
- **FULL OUTER JOIN**: Retrieve all records from both tables, with NULLs where no match exists.
- **Subqueries**: Write both non-correlated and correlated subqueries for complex filtering and aggregation.

These queries simulate real-world scenarios faced by Airbnb-like platforms, such as retrieving bookings with user details, listing properties with reviews, analyzing average ratings, and tracking user activity.

---

## 🔑 Learning Objectives

- Write complex SQL queries using different types of joins.
- Understand the differences and use cases for INNER, LEFT, and FULL OUTER JOINs.
- Write and differentiate between non-correlated and correlated subqueries.
- Analyze query results and handle NULL values effectively.
- Prepare for real-world database querying and optimization challenges.

---

## 📂 Repository Structure

alx-airbnb-database/
│
└── database-adv-script/
├── joins_queries.sql # SQL queries for INNER, LEFT, FULL OUTER JOINs
├── subqueries.sql # SQL queries for non-correlated and correlated subqueries
└── README.md # Project documentation (this file)

---

## 📝 Queries Overview

### Joins

#### 1. INNER JOIN — Bookings with Users

SELECT b.booking_id, b.property_id, b.start_date, b.end_date,
u.user_id, u.first_name, u.last_name, u.email
FROM booking b
INNER JOIN users u ON b.user_id = u.user_id;

*Retrieves all bookings along with the users who made them.*

---

#### 2. LEFT JOIN — Properties with Reviews

SELECT p.property_id, p.name, r.review_id, r.rating, r.comment, r.created_at
FROM properties p
LEFT JOIN review r ON p.property_id = r.property_id
ORDER BY p.name ASC, r.created_at DESC;

*Retrieves all properties and their reviews, including properties without any reviews.*

---

#### 3. FULL OUTER JOIN — Users and Bookings

SELECT u.user_id, u.first_name, u.last_name,
b.booking_id, b.property_id, b.start_date, b.end_date
FROM users u
FULL OUTER JOIN booking b ON u.user_id = b.user_id;

*Retrieves all users and all bookings, including users without bookings and bookings not linked to users.*

---

### Subqueries

#### 1. Non-Correlated Subquery — Properties with Average Rating > 4.0

SELECT p.property_id, p.name, p.location
FROM properties p
WHERE p.property_id IN (
SELECT r.property_id
FROM review r
GROUP BY r.property_id
HAVING AVG(r.rating) > 4.0
);

*Retrieves all properties whose average rating exceeds 4.0.  
The subquery calculates average ratings independently of the outer query.*

---

#### 2. Correlated Subquery — Users with More Than 3 Bookings

SELECT u.user_id, u.first_name, u.last_name, u.email
FROM users u
WHERE (
SELECT COUNT(*)
FROM booking b
WHERE b.user_id = u.user_id
) > 3;

*Finds users who have made more than three bookings.  
The subquery counts bookings per user, referencing the outer query's user ID.*

---

## 🚀 How to Run

1. Ensure your PostgreSQL database is set up and seeded with the Airbnb clone schema and sample data.
2. Run the queries in `joins_queries.sql` and `subqueries.sql` using a SQL client or `psql`.
3. Analyze the results and verify correctness.

---

## 📈 Performance Tips

- Use `EXPLAIN ANALYZE` to understand query execution plans.
- Create indexes on foreign keys (`user_id`, `property_id`) to speed up joins and subqueries.
- Handle NULL values in FULL OUTER JOIN results carefully in your application.

---
### 📊 Aggregation and Window Functions

Unlock powerful data analysis techniques with SQL **aggregation** and **window functions**! These queries help you summarize user activity and rank properties by popularity in your Airbnb clone database.

---

#### 1️⃣ Total Number of Bookings Made by Each User

SELECT
u.user_id,
u.first_name,
u.last_name,
COUNT(b.booking_id) AS total_bookings
FROM users u
LEFT JOIN booking b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;

> **What it does:**  
> Counts how many bookings each user has made — including those with zero bookings!  
> Uses `COUNT()` with `GROUP BY` and a `LEFT JOIN` to include all users.  
> Results are sorted to show the most active users first.

---

#### 2️⃣ Rank Properties Based on Total Number of Bookings

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


> **What it does:**  
> Ranks properties by how many bookings they have received.  
> Uses the window function `RANK()` to assign the same rank to ties.  
> Includes properties with zero bookings thanks to `LEFT JOIN`.

---

#### 🔄 Optional: Unique Ranking with `ROW_NUMBER()`

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

> **When to use:**  
> Use `ROW_NUMBER()` if you want each property to have a unique rank, even when booking counts tie.

---

### 🚀 How to Run

1. Make sure your PostgreSQL database is seeded with the Airbnb clone schema and sample data.  
2. Run these queries in your SQL client or `psql`.  
3. Explore the results to gain insights into user booking behavior and property popularity!

---

✨ **Tip:** Use `EXPLAIN ANALYZE` to check query performance and optimize indexes for faster results.

---

---

## 🤝 Contributions & Feedback

Contributions, suggestions, and improvements are welcome! Please open an issue or submit a pull request.

---

## 🎉 Happy querying and learning!

---

*Developed as part of the ALX Airbnb Database Module.*


