
# Airbnb Clone Database Seed Script

Welcome to the **Airbnb Clone** database seed script! This script populates your PostgreSQL database with realistic sample data, demonstrating key relationships between users, properties, bookings, payments, reviews, and messages.

---

## 🚀 Project Overview

This project is part of my personal web development journey focused on building a fully functional Airbnb clone. It includes:

- Designing database schemas and ER diagrams
- Troubleshooting PostgreSQL constraints and data seeding
- Showcasing backend functionality with realistic sample data

---

## 📋 Seed Script Contents

| Table      | Description                                         |
|------------|-----------------------------------------------------|
| `users`    | Hosts, guests, and admins with unique emails & roles |
| `properties` | Listings owned by hosts with location & pricing     |
| `booking`  | Reservations made by guests with status tracking     |
| `payment`  | Payments linked to bookings with valid methods       |
| `review`   | Guest reviews with ratings and comments              |
| `message`  | Communication between users (guests & hosts)         |

---

## ⚙️ How to Run

1. **Ensure your database schema matches the expected structure**, including UUID defaults and check constraints.

2. **Enable the UUID extension** if not already enabled:

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

text

3. **Run the seed script** using the `psql` command-line tool:

psql -U linda -d airbnb -f seed.sql

text

Replace `linda` and `airbnb` with your PostgreSQL username and database name.

---

## 🔍 Verify Seeded Data

After running the script, explore the seeded data with:

SELECT * FROM users;
SELECT * FROM properties;
SELECT * FROM booking;
SELECT * FROM payment;
SELECT * FROM review;
SELECT * FROM message;

text

---

## 💡 Important Notes

- Password hashes in this seed are placeholders (`hash1`, `hash2`, etc.). Replace with actual bcrypt hashes for production.
- The `location` field in `properties` uses simple city names as text.
- Enum-like fields (`booking.status`, `payment.payment_method`) use **lowercase** values to satisfy check constraints.
- The script truncates tables first to avoid duplicate key errors—safe for development and testing.

---

## 🙋 About Me

I’m passionate about web development and enjoy sharing updates on Discord and Twitter. This Airbnb clone is a key milestone in my portfolio, managed actively on GitHub.

---

## 🤝 Contributions & Feedback

Feel free to open issues or pull requests if you have suggestions or improvements!

---

> *“If we pull together and commit ourselves, then we can push through anything.”*  
> — Mona the Octocat

---

*Happy coding and happy hosting!* 🎉
