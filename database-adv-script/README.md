# ALX Airbnb Database Module — Advanced SQL Joins

Welcome to the **ALX Airbnb Database Module** project! This repository contains SQL queries demonstrating advanced join operations on a simulated Airbnb database.

---

## 📚 Project Overview

This project focuses on mastering **SQL JOINs** to extract meaningful insights by combining data from multiple related tables. You will write queries using:

- **INNER JOIN**: Retrieve records with matching values in both tables.
- **LEFT JOIN**: Retrieve all records from the left table and matched records from the right.
- **FULL OUTER JOIN**: Retrieve all records from both tables, with NULLs where no match exists.

These queries simulate real-world scenarios faced by Airbnb-like platforms, such as retrieving bookings with user details, listing properties with reviews, and combining users with their bookings.

---

## 🔑 Learning Objectives

- Write complex SQL queries using different types of joins.
- Understand the differences and use cases for INNER, LEFT, and FULL OUTER JOINs.
- Analyze query results and handle NULL values effectively.
- Prepare for real-world database querying and optimization challenges.

---

## 📂 Repository Structure

alx-airbnb-database/
│
└── database-adv-script/
├── joins_queries.sql # SQL queries for INNER, LEFT, FULL OUTER JOINs
└── README.md # Project documentation (this file)


---

## 📝 Queries Overview

### 1. INNER JOIN — Bookings with Users

SELECT b.booking_id, b.property_id, b.start_date, b.end_date,
u.user_id, u.first_name, u.last_name, u.email
FROM booking b
INNER JOIN users u ON b.user_id = u.user_id;


*Retrieves all bookings along with the users who made them.*

---

### 2. LEFT JOIN — Properties with Reviews

SELECT p.property_id, p.name, r.review_id, r.rating, r.comment
FROM properties p
LEFT JOIN review r ON p.property_id = r.property_id;



*Retrieves all properties and their reviews, including properties without any reviews.*

---

### 3. FULL OUTER JOIN — Users and Bookings

SELECT u.user_id, u.first_name, u.last_name,
b.booking_id, b.property_id, b.start_date, b.end_date
FROM users u
FULL OUTER JOIN booking b ON u.user_id = b.user_id;



*Retrieves all users and all bookings, including users without bookings and bookings not linked to users.*

---

## 🚀 How to Run

1. Ensure your PostgreSQL database is set up and seeded with the Airbnb clone schema and sample data.
2. Run the queries in `joins_queries.sql` using a SQL client or `psql`.
3. Analyze the results and verify correctness.

---

## 📈 Performance Tips

- Use `EXPLAIN ANALYZE` to understand query execution plans.
- Create indexes on foreign keys (`user_id`, `property_id`) to speed up joins.
- Handle NULL values in FULL OUTER JOIN results carefully in your application.

---

## 🤝 Contributions & Feedback

Contributions, suggestions, and improvements are welcome! Please open an issue or submit a pull request.

---

## 🎉 Happy querying and learning!

---

*Developed as part of the ALX Airbnb Database Module.*
