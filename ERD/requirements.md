# ER Diagram Requirements for Airbnb Clone Project

## 📖Overview

This document describes the Entity-Relationship (ER) diagram created for the Airbnb clone project. The ER diagram models the core database schema needed to support the main functionalities of the application, including user management, property listings, bookings, payments, reviews, and messaging.

## 🎇Entities and Attributes

The ER diagram includes the following entities with their key attributes:

- **User**: Represents users of the platform with roles such as guest, host, and admin.
- **Property**: Details of properties listed by hosts.
- **Booking**: Records of bookings made by users for properties.
- **Payment**: Payment information linked to bookings.
- **Review**: User reviews and ratings for properties.
- **Message**: Communication between users.

## Detailed Relationships and Schema Explanation

### 1. 👥User Entity

- Represents all users of the platform, including guests, hosts, and admins.
- Attributes include personal details (`first_name`, `last_name`, `email`), authentication info (`password_hash`), contact (`phone_number`), and `role`.
- **Role** determines the user’s capabilities:  
  - *Guest*: Can book properties, write reviews, send messages.  
  - *Host*: Can list properties, manage bookings, respond to messages.  
  - *Admin*: Oversees platform operations.

### 2. 🏢Property Entity

- Represents listings created by hosts.
- Each property is linked to exactly one host via `host_id` (foreign key to User).
- Attributes include descriptive details (`name`, `description`, `location`), pricing (`pricepernight`), and timestamps (`created_at`, `updated_at`).
- A host can have multiple properties (one-to-many relationship).

### 3. 📚Booking Entity

- Represents reservations made by guests for properties.
- Linked to one property (`property_id`) and one user (`user_id`) who made the booking.
- Includes booking details such as `start_date`, `end_date`, `total_price`, and `status` (pending, confirmed, canceled).
- One property can have many bookings over time (one-to-many).
- One user can make many bookings (one-to-many).

### 4. 💵Payment Entity

- Represents payment transactions for bookings.
- Each payment is linked to exactly one booking (`booking_id`).
- Attributes include `amount`, `payment_date`, and `payment_method` (credit card, PayPal, Stripe).
- One-to-one relationship with Booking ensures each booking has a corresponding payment record.

### 5. ✨Review Entity

- Represents feedback from users about properties.
- Linked to both the property being reviewed (`property_id`) and the user who wrote the review (`user_id`).
- Includes `rating` (1 to 5), `comment`, and timestamp.
- One property can have many reviews (one-to-many).
- One user can write many reviews (one-to-many).

### 6. 📩Message Entity

- Represents communication between users.
- Each message has a sender (`sender_id`) and recipient (`recipient_id`), both referencing User.
- Includes message content and timestamp.
- One user can send many messages and receive many messages (two one-to-many relationships).

## 🤝Summary of Relationships

| Relationship                      | Type           | Description                                  |
|---------------------------------|----------------|----------------------------------------------|
| User (host) → Property           | One-to-Many    | A host lists multiple properties             |
| User (guest) → Booking           | One-to-Many    | A guest can make multiple bookings            |
| Property → Booking               | One-to-Many    | A property can have multiple bookings         |
| Booking → Payment                | One-to-One     | Each booking has one payment                   |
| User → Review                   | One-to-Many    | A user can write multiple reviews              |
| Property → Review               | One-to-Many    | A property can have multiple reviews           |
| User (sender) → Message          | One-to-Many    | A user can send many messages                  |
| User (recipient) → Message       | One-to-Many    | A user can receive many messages               |

## Purpose📘📘

The ER diagram serves as a blueprint for the database design, ensuring data integrity and supporting the application’s business logic. It guides the development of SQL schemas, API endpoints, and application features.

## File Location

🖇️The ER diagram file is located in this directory as:

- `airbnb_erd.drawio` 

---

*This documentation provides a detailed understanding of the database schema and relationships for the Airbnb clone project, facilitating smooth development and collaboration.*
