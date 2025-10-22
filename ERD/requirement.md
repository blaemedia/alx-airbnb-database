
# 🏡 Database Schema Overview

This document describes the entities, attributes, and relationships for the system’s relational database (similar to an Airbnb-style platform).

---

## 📘 Entities and Attributes

### **1. User**
**Primary Key:** `user_id`  
**Attributes:**
- `first_name`: `VARCHAR`, **NOT NULL**  
- `last_name`: `VARCHAR`, **NOT NULL**  
- `email`: `VARCHAR`, **UNIQUE**, **NOT NULL**  
- `password_hash`: `VARCHAR`, **NOT NULL**  
- `phone_number`: `VARCHAR`, `NULL`  
- `role`: `ENUM('guest', 'host', 'admin')`, **NOT NULL**  
- `created_at`: `TIMESTAMP`, `DEFAULT CURRENT_TIMESTAMP`

---

### **2. Property**
**Primary Key:** `property_id`  
**Foreign Key:** `host_id → User(user_id)`  
**Attributes:**
- `name`: `VARCHAR`, **NOT NULL**  
- `description`: `TEXT`, **NOT NULL**  
- `location`: `VARCHAR`, **NOT NULL**  
- `pricepernight`: `DECIMAL`, **NOT NULL**  
- `created_at`: `TIMESTAMP`, `DEFAULT CURRENT_TIMESTAMP`  
- `updated_at`: `TIMESTAMP`, `ON UPDATE CURRENT_TIMESTAMP`

---

### **3. Booking**
**Primary Key:** `booking_id`  
**Foreign Keys:**  
- `property_id → Property(property_id)`  
- `user_id → User(user_id)`  

**Attributes:**
- `start_date`: `DATE`, **NOT NULL**  
- `end_date`: `DATE`, **NOT NULL**  
- `total_price`: `DECIMAL`, **NOT NULL**  
- `status`: `ENUM('pending', 'confirmed', 'canceled')`, **NOT NULL**  
- `created_at`: `TIMESTAMP`, `DEFAULT CURRENT_TIMESTAMP`

---

### **4. Payment**
**Primary Key:** `payment_id`  
**Foreign Key:** `booking_id → Booking(booking_id)`  
**Attributes:**
- `amount`: `DECIMAL`, **NOT NULL**  
- `payment_date`: `TIMESTAMP`, `DEFAULT CURRENT_TIMESTAMP`  
- `payment_method`: `ENUM('credit_card', 'paypal', 'stripe')`, **NOT NULL**

---

### **5. Review**
**Primary Key:** `review_id`  
**Foreign Keys:**  
- `property_id → Property(property_id)`  
- `user_id → User(user_id)`  

**Attributes:**
- `rating`: `INTEGER`, **CHECK:** `rating BETWEEN 1 AND 5`, **NOT NULL**  
- `comment`: `TEXT`, **NOT NULL**  
- `created_at`: `TIMESTAMP`, `DEFAULT CURRENT_TIMESTAMP`

---

### **6. Message**
**Primary Key:** `message_id`  
**Foreign Keys:**  
- `sender_id → User(user_id)`  
- `recipient_id → User(user_id)`  

**Attributes:**
- `message_body`: `TEXT`, **NOT NULL**  
- `sent_at`: `TIMESTAMP`, `DEFAULT CURRENT_TIMESTAMP`

---

## ⚙️ Constraints

### **User Table**
- Unique constraint on `email`  
- Non-null constraints on required fields  

### **Property Table**
- Foreign key constraint on `host_id`  
- Non-null constraints on essential attributes  

### **Booking Table**
- Foreign key constraints on `property_id` and `user_id`  
- `status` must be one of `('pending', 'confirmed', 'canceled')`  

### **Payment Table**
- Foreign key constraint on `booking_id`  
- Ensures each payment links to a valid booking  

### **Review Table**
- Foreign key constraints on `property_id` and `user_id`  
- Constraint: `rating` must be between 1 and 5  

### **Message Table**
- Foreign key constraints on `sender_id` and `recipient_id`

---

## 🧭 Indexing

- **Primary Keys:** Indexed automatically  
- **Additional Indexes:**
  - `email` in **User** table  
  - `property_id` in **Property** and **Booking** tables  
  - `booking_id` in **Booking** and **Payment** tables  

---

## 🔗 Relationships Between Entities

| From Entity | To Entity | Relationship Type | Description |
|--------------|------------|-------------------|--------------|
| **User** | **Property** | One-to-Many | A host can have many properties |
| **User** | **Booking** | One-to-Many | A guest can make many bookings |
| **Property** | **Booking** | One-to-Many | A property can have many bookings |
| **Booking** | **Payment** | One-to-One / One-to-Many | A booking has one (or more) payments |
| **User ↔ Property** | via **Review** | Many-to-Many | Guests can review multiple properties |
| **User ↔ User** | via **Message** | Many-to-Many | Users can send messages to each other |

---

## 🧩 Cardinality Summary

- **User → Property:** 1️⃣ ➜ 🌐 Many (One host, many properties)  
- **User → Booking:** 1️⃣ ➜ 🌐 Many (One guest, many bookings)  
- **Property → Booking:** 1️⃣ ➜ 🌐 Many (One property, many bookings)  
- **Booking → Payment:** 1️⃣ ➜ 1️⃣ (Typically one payment per booking)  
- **User ↔ Property (Review):** 🌐 ➜ 🌐 (Many users review many properties)  
- **User ↔ User (Message):** 🌐 ➜ 🌐 (Users message each other)

---

## 🧠 Notes

- All **UUIDs** are unique identifiers for scalability.  
- **Timestamps** track creation and updates automatically.  
- **ENUM fields** restrict values to valid states (e.g., roles, status).  
- **Relationships** enforce referential integrity via foreign keys.

---

## 🧩 Entity Relationship Diagram

Below is the visual representation of the database entities and their relationships:

![Entity Relationship Diagram](./alx-airbnb-databaseER-diagram.png)
