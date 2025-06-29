# 🗃️ Database Normalization to Third Normal Form (3NF)

---

## 🎯 Objective

Ensure the Airbnb clone database schema is normalized to **Third Normal Form (3NF)** to:

- Eliminate data redundancy
- Avoid update, insertion, and deletion anomalies
- Maintain data integrity
- Support efficient and reliable queries

---

## 📚 What is Third Normal Form (3NF)?

3NF requires that:

- The database is already in **Second Normal Form (2NF)**.
- There are **no transitive dependencies**; i.e., non-key attributes depend **only** on the primary key, **not** on other non-key attributes.

> **Transitive dependency example:**  
> Column A → Column B  
> Column B → Column C  
> Here, Column C depends on B, which depends on A, violating 3NF.

---

## 🔎 Review of the Airbnb Schema for Normalization

### Entities and Attributes Recap

| Entity    | Primary Key | Key Attributes (sample)                           |
| :-------- | :---------- | :----------------------------------------------- |
| **User**     | `user_id`    | `first_name`, `last_name`, `email`, `role`        |
| **Property** | `property_id`| `host_id` (FK), `name`, `location`, `pricepernight` |
| **Booking**  | `booking_id` | `property_id` (FK), `user_id` (FK), `start_date`, `status` |
| **Payment**  | `payment_id` | `booking_id` (FK), `amount`, `payment_method`     |
| **Review**   | `review_id`  | `property_id` (FK), `user_id` (FK), `rating`, `comment` |
| **Message**  | `message_id` | `sender_id` (FK), `recipient_id` (FK), `message_body` |

---

## ✅ Step 1: Check for Partial Dependencies (2NF)

- All tables use **single-column primary keys** (UUIDs).
- No composite keys → no partial dependencies.
- **Conclusion:** Schema satisfies **Second Normal Form (2NF)**.

---

## ✅ Step 2: Identify Transitive Dependencies (3NF)

- Check if any non-key attribute depends on another non-key attribute.

| Table    | Transitive Dependency? | Explanation                                  |
| -------- | --------------------- | --------------------------------------------|
| User     | No                    | All attributes depend only on `user_id`.    |
| Property | No                    | Attributes depend on `property_id` only.    |
| Booking  | No                    | Attributes depend on `booking_id` only.     |
| Payment  | No                    | Attributes depend on `payment_id` only.     |
| Review   | No                    | Attributes depend on `review_id` only.      |
| Message  | No                    | Attributes depend on `message_id` only.     |

- No transitive dependencies found.

---

## 🔧 Step 3: Verify and Adjust if Needed

- Example of a transitive dependency to fix (not present here):  
  If `city` and `state` depended on `zip_code` stored in User or Property, move `city` and `state` to a separate table keyed by `zip_code`.
- Since no such dependencies exist, **no changes needed**.

---

## 📊 Summary of Normal Forms Compliance

| Normal Form | Criteria                                   | Status for Airbnb Schema                 |
|-------------|--------------------------------------------|-----------------------------------------|
| 1NF         | Atomic values, no repeating groups          | ✔ Met                                  |
| 2NF         | No partial dependency on composite keys     | ✔ Met (no composite keys)               |
| 3NF         | No transitive dependencies                   | ✔ Met (all non-key attributes depend only on PK) |

---

## 🌟 Benefits of 3NF Compliance

- **Reduces data redundancy**  
- **Improves data integrity**  
- **Simplifies maintenance and updates**  
- **Optimizes query performance**

---

## 📖 References

- [Normalization in SQL DBMS: 1NF, 2NF, 3NF, and BCNF Examples](https://popsql.com/blog/normalization-in-sql)  
- [Third Normal Form in DBMS - BYJU'S](https://byjus.com/gate/third-normal-form-in-dbms/)  
- [What is Third Normal Form (3NF)? - DataCamp](https://www.datacamp.com/tutorial/third-normal-form)

---

*This normalization review confirms that the Airbnb clone database schema is well-structured and normalized to Third Normal Form (3NF), ensuring efficient, consistent, and reliable data management.*
