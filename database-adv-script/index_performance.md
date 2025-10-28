# 🗄️ Database Index Optimization

This document identifies high-usage columns in the **Users**, **Bookings**, and **Properties** tables, creates appropriate indexes for better performance, and shows how to measure query efficiency **before and after** indexing using `EXPLAIN ANALYZE`.

---

## 🔍 Step 1: Identify High-Usage Columns

| Table | High-Usage Columns | Reason |
|-------|--------------------|--------|
| **Users** | `email`, `created_at` | Used in WHERE filters and sorting by date |
| **Bookings** | `user_id`, `property_id`, `booking_date`, `status` | Used in JOINs, filters, and sorting |
| **Properties** | `city`, `price`, `rating` | Used in filtering and ranking queries |

---

## ⚙️ Step 2: Create Indexes

Below are the SQL `CREATE INDEX` statements that should be saved in **`database_index.sql`**.

```sql
-- USERS TABLE INDEXES
CREATE INDEX idx_users_email ON users (email);
CREATE INDEX idx_users_created_at ON users (created_at);

-- BOOKINGS TABLE INDEXES
CREATE INDEX idx_bookings_user_id ON bookings (user_id);
CREATE INDEX idx_bookings_property_id ON bookings (property_id);
CREATE INDEX idx_bookings_booking_date ON bookings (booking_date);
CREATE INDEX idx_bookings_status ON bookings (status);

-- PROPERTIES TABLE INDEXES
CREATE INDEX idx_properties_city ON properties (city);
CREATE INDEX idx_properties_price ON properties (price);
CREATE INDEX idx_properties_rating ON properties (rating);

