# 🏠 Airbnb Clone Database Schema

---

## 📖 Project Overview

Welcome to the **Airbnb Clone Database Schema** repository! This project defines a robust and scalable relational database schema designed to power the core functionalities of an Airbnb-like platform.

The schema supports:

- User management with distinct roles (guest, host, admin)  
- Property listings and host associations  
- Booking and reservation management  
- Payment processing and tracking  
- User reviews and ratings  
- Messaging between users  

This database design ensures data integrity, efficient querying, and maintainability.

---

## 🗂️ Schema Structure and Entities

| Entity    | Description                                                  |
| --------- | ------------------------------------------------------------ |
| **Users**     | Stores user details including authentication and roles       |
| **Properties**| Contains property listings linked to hosts                   |
| **Bookings**  | Records reservations made by guests for properties           |
| **Payments**  | Tracks payments associated with bookings                      |
| **Reviews**   | Stores user-generated reviews and ratings for properties     |
| **Messages**  | Facilitates communication between users                       |

---

## 🔍 Detailed Schema Explanation

### 1. 👤 Users

- **Primary Key:** `user_id` (UUID)  
- **Key Attributes:** `first_name`, `last_name`, `email` (unique), `password_hash`, `phone_number`, `role` (guest, host, admin), `created_at`  
- **Constraints:**  
  - Email is unique to prevent duplicates  
  - Role is restricted to predefined values using CHECK constraints  
- **Indexes:** Unique index on `email` for fast lookups  

### 2. 🏠 Properties

- **Primary Key:** `property_id` (UUID)  
- **Foreign Key:** `host_id` references `users(user_id)`  
- **Attributes:** `name`, `description`, `location`, `pricepernight`, `created_at`, `updated_at`  
- **Constraints:**  
  - Price must be non-negative  
- **Indexes:** Index on `host_id` to optimize queries filtering by host  

### 3. 📅 Bookings

- **Primary Key:** `booking_id` (UUID)  
- **Foreign Keys:** `property_id`, `user_id`  
- **Attributes:** `start_date`, `end_date`, `total_price`, `status` (pending, confirmed, canceled), `created_at`  
- **Constraints:**  
  - Booking dates validated (`end_date >= start_date`)  
  - Status restricted to predefined values  
- **Indexes:** Indexes on `property_id` and `user_id` for efficient joins  

### 4. 💳 Payments

- **Primary Key:** `payment_id` (UUID)  
- **Foreign Key:** `booking_id` (unique)  
- **Attributes:** `amount`, `payment_date`, `payment_method` (credit_card, paypal, stripe)  
- **Constraints:**  
  - Payment amount must be non-negative  
  - Payment method restricted to allowed values  
- **Indexes:** Index on `booking_id`  

### 5. ⭐ Reviews

- **Primary Key:** `review_id` (UUID)  
- **Foreign Keys:** `property_id`, `user_id`  
- **Attributes:** `rating` (1-5), `comment`, `created_at`  
- **Constraints:**  
  - Rating constrained between 1 and 5  
- **Indexes:** Indexes on `property_id` and `user_id`  

### 6. 💬 Messages

- **Primary Key:** `message_id` (UUID)  
- **Foreign Keys:** `sender_id`, `recipient_id` (both reference `users`)  
- **Attributes:** `message_body`, `sent_at`  
- **Indexes:** Indexes on `sender_id` and `recipient_id`  

---

## ⚙️ Constraints and Indexing Strategy

- **Primary Keys:** Uniquely identify records using UUIDs for scalability.  
- **Foreign Keys:** Enforce referential integrity between related tables with cascading deletes where appropriate.  
- **CHECK Constraints:** Ensure data validity for enumerated types and value ranges.  
- **Unique Constraints:** Prevent duplicate entries (e.g., unique emails).  
- **Indexes:** Applied on frequently queried columns (foreign keys, unique fields) to speed up data retrieval.

---

## 🚀 How to Use

1. **Run the SQL script** in `database-script-0x01/schema.sql` to create the database schema in your PostgreSQL (or compatible) environment.  
2. Ensure the `pgcrypto` extension is enabled if using PostgreSQL for UUID generation:  

