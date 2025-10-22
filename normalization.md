
# 🧩 Database Normalization — Airbnb Clone

## 1️⃣ First Normal Form (1NF)

**Rule:**  
Each column should contain atomic (indivisible) values, and each record must be unique.

**Application:**  
- Each table has a **Primary Key** (`user_id`, `property_id`, `booking_id`, etc.).  
- There are **no repeating groups or arrays** — for example, each user has only one email address per record.  
- All attributes contain **single values**, not lists or sets.  

✅ Therefore, all tables satisfy **1NF**.

---

## 2️⃣ Second Normal Form (2NF)

**Rule:**  
Be in 1NF and ensure that all **non-key attributes** are fully dependent on the entire primary key.

**Application:**  
- Every table uses a **single-column primary key** (UUID).  
- No table has a composite key, so partial dependencies cannot exist.  
- Attributes like `email`, `pricepernight`, and `start_date` depend entirely on their respective table’s primary key.  

✅ Therefore, all tables satisfy **2NF**.

---

## 3️⃣ Third Normal Form (3NF)

**Rule:**  
Be in 2NF and ensure that there are **no transitive dependencies** (non-key attributes depending on other non-key attributes).

**Application:**  
- In the **User** table, attributes such as `email`, `role`, and `phone_number` depend directly on `user_id`, not on one another.  
- In the **Property** table, attributes like `name`, `location`, and `pricepernight` depend only on `property_id`.  
- In the **Booking** table, attributes like `total_price` depend on `booking_id` rather than indirectly on `property_id`.  
- In the **Payment** table, `amount` and `payment_date` depend on `payment_id`, not on `booking_id`.  
- In the **Review** table, `rating` and `comment` depend only on `review_id`.  
- In the **Message** table, `message_body` depends only on `message_id`.  

✅ Therefore, all tables satisfy **3NF**.

---

## ⚙️ Normalization Summary

| Table | 1NF | 2NF | 3NF | Notes |
|-------|------|------|------|------|
| **User** | ✅ | ✅ | ✅ | All attributes depend on `user_id` |
| **Property** | ✅ | ✅ | ✅ | `host_id` correctly references `User` |
| **Booking** | ✅ | ✅ | ✅ | Attributes depend only on `booking_id` |
| **Payment** | ✅ | ✅ | ✅ | Linked correctly to valid `booking_id` |
| **Review** | ✅ | ✅ | ✅ | Attributes depend only on `review_id` |
| **Message** | ✅ | ✅ | ✅ | Sender and recipient reference `User` |

---

## 🧠 Conclusion

The Airbnb database schema meets the requirements of **Third Normal Form (3NF)**.  
There are **no redundant data fields**, and **all relationships** are properly managed using **foreign keys**.  
This ensures data consistency, scalability, and integrity across all entities.
