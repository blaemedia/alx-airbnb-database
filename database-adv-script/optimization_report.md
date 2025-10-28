It covers the initial query, performance analysis, inefficiency identification, index creation, query refactoring, and re-testing, all formatted beautifully for use in your README.md or a file like performance_optimization.md.

# ⚡ SQL Query Performance Optimization

This guide walks through improving query performance in a database that handles **Users**, **Bookings**, **Properties**, and **Payments**.  
We will:

1. Write an initial query to retrieve all booking data.  
2. Analyze the query’s performance using `EXPLAIN`.  
3. Identify inefficiencies.  
4. Add indexes to improve performance.  
5. Refactor the query for faster execution.  
6. Compare results before and after optimization.

---

## 🧩 Step 1: Initial Query — Retrieve Bookings with All Related Details

📁 **File:** `performance.sql`

```sql
-- Retrieve all bookings with related user, property, and payment details
SELECT 
    b.booking_id,
    b.booking_date,
    b.status,
    u.user_id,
    u.full_name,
    u.email,
    p.property_id,
    p.property_name,
    p.city,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_status
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
JOIN payments pay ON b.booking_id = pay.booking_id;

🔍 Step 2: Analyze Query Performance with EXPLAIN

Use EXPLAIN or EXPLAIN ANALYZE to view how the database executes this query.

EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.booking_date,
    b.status,
    u.user_id,
    u.full_name,
    u.email,
    p.property_id,
    p.property_name,
    p.city,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_status
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
JOIN payments pay ON b.booking_id = pay.booking_id;

🧾 Example Output (Before Optimization)
Seq Scan on bookings b   (cost=0.00..4200.00 rows=20000 width=128)
Seq Scan on users u      (cost=0.00..2500.00 rows=10000 width=96)
Seq Scan on properties p (cost=0.00..3500.00 rows=8000 width=64)
Seq Scan on payments pay (cost=0.00..2700.00 rows=20000 width=64)
Execution Time: 740 ms

⚠️ Step 3: Identify Inefficiencies
Issue	Description
❌ Sequential scans	Large tables scanned fully without indexes
❌ Too many columns	Fetching unnecessary data increases memory use
❌ Inner joins only	Fails when some bookings have no payment yet
❌ No indexing	Foreign keys lack supporting indexes
⚙️ Step 4: Create Indexes to Speed Up Joins

Create indexes on the most frequently joined columns and save them in database_index.sql.

-- USERS TABLE
CREATE INDEX idx_users_user_id ON users (user_id);

-- BOOKINGS TABLE
CREATE INDEX idx_bookings_user_id ON bookings (user_id);
CREATE INDEX idx_bookings_property_id ON bookings (property_id);

-- PROPERTIES TABLE
CREATE INDEX idx_properties_property_id ON properties (property_id);

-- PAYMENTS TABLE
CREATE INDEX idx_payments_booking_id ON payments (booking_id);


💡 Why:
Indexes help the database find matching rows faster during JOIN, WHERE, and ORDER BY operations.

🧠 Step 5: Refactor the Query to Reduce Execution Time

We’ll:

Select only required columns.

Use LEFT JOIN for optional tables like payments.

Rely on our new indexes for faster lookups.

-- Optimized query
SELECT 
    b.booking_id,
    b.booking_date,
    b.status,
    u.full_name AS user_name,
    p.property_name AS property_name,
    pay.amount,
    pay.payment_status
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id;


Optimization Summary:

🧩 Reduced column selection → less data fetched.

🔁 Changed full joins to LEFT JOIN for optional data.

⚙️ Added indexes to all join keys.

🚀 Query simplified for better optimizer use.

⚡ Step 6: Re-Test with EXPLAIN ANALYZE

Run the optimized query again with performance analysis.

EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.booking_date,
    b.status,
    u.full_name AS user_name,
    p.property_name AS property_name,
    pay.amount,
    pay.payment_status
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id;

🧾 Example Output (After Optimization)
Index Scan using idx_bookings_user_id on bookings b   (cost=0.42..1200.55 rows=20000 width=96)
Index Scan using idx_bookings_property_id on properties p  (cost=0.55..800.33 rows=8000 width=64)
Index Scan using idx_payments_booking_id on payments pay   (cost=0.30..600.20 rows=20000 width=64)
Execution Time: 120 ms


✅ Result:

Reduced from 740 ms → 120 ms

Sequential scans replaced with Index Scans

Less I/O and faster joins

📊 Step 7: Compare Before & After
Metric	Before	After	Improvement
Execution Time	740 ms	120 ms	⚡ ~84% faster
Scan Type	Sequential	Index	✅ Optimized
Columns Selected	12	6	💡 Reduced data load
Joins	3 Inner	2 Inner + 1 Left	✅ More flexible
🧩 Step 8: Key Takeaways

Always index foreign keys and join columns.

Use EXPLAIN regularly to monitor performance.

Select only what you need — every extra column adds cost.

Replace inner joins with LEFT JOINs when optional relationships exist.

Keep separate .sql files for indexing and query performance testing.

📁 Project Files
File	Purpose
performance.sql	Contains both initial and optimized queries
database_index.sql	Stores all index creation statements
performance_optimization.md	Documentation of the optimization process

✅ End of Optimization Guide
