## 🧠 Task: Booking Performance Optimization
Create a query to retrieve all bookings along with user, property, and payment details.

-- performance.sql

-- Step 1: Retrieve all booking data with related user, property, and payment details
SELECT 
    b.booking_id,
    b.booking_date,
    b.check_in_date,
    b.check_out_date,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.status
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Properties p ON b.property_id = p.property_id
LEFT JOIN Payments pay ON b.booking_id = pay.booking_id;


##Step 2: Analyze Query Performance
To analyze how the database executes this query, use:
EXPLAIN SELECT 
    b.booking_id,
    b.booking_date,
    b.check_in_date,
    b.check_out_date,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.status
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Properties p ON b.property_id = p.property_id
LEFT JOIN Payments pay ON b.booking_id = pay.booking_id;

##What to Look For
The EXPLAIN output will reveal:
Type: e.g., ALL (full scan), INDEX, REF, etc.
Rows: estimated rows scanned per table
Possible_keys: which indexes could be used
Key_used: which index is actually used
  
🚩 Inefficiencies may include:
Full table scans (ALL) instead of index lookups
Missing indexes on JOIN columns (user_id, property_id, booking_id)
Large temporary tables or Using filesort in the Extra column

##Step 3: Refactor and Optimize the Query
✅ Add Indexes
To improve performance, create indexes on high-usage columns used in JOIN and WHERE clauses:
-- Add indexes for faster joins
CREATE INDEX idx_user_id ON Users(user_id);
CREATE INDEX idx_property_id ON Properties(property_id);
CREATE INDEX idx_booking_user ON Bookings(user_id);
CREATE INDEX idx_booking_property ON Bookings(property_id);
CREATE INDEX idx_payment_booking ON Payments(booking_id);

##✅ Optimized Query
If your goal is to view recent bookings or specific timeframes, limit unnecessary data retrieval:

-- Optimized version using indexes and reduced scope
SELECT 
    b.booking_id,
    b.booking_date,
    u.first_name,
    u.last_name,
    p.property_name,
    pay.amount,
    pay.status
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Properties p ON b.property_id = p.property_id
LEFT JOIN Payments pay ON b.booking_id = pay.booking_id
WHERE b.booking_date >= DATE_SUB(NOW(), INTERVAL 6 MONTH)
ORDER BY b.booking_date DESC;

  
-- Add indexes for faster joins
CREATE INDEX idx_user_id ON Users(user_id);
CREATE INDEX idx_property_id ON Properties(property_id);
CREATE INDEX idx_booking_user ON Bookings(user_id);
CREATE INDEX idx_booking_property ON Bookings(property_id);
CREATE INDEX idx_payment_booking ON Payments(booking_id);

##🔍 Why This Is Faster
Indexes reduce join lookup times
Limiting the date range prevents full table scans
Selecting only required columns reduces I/O load

## Step 4: Re-Analyze Performance
EXPLAIN SELECT 
    b.booking_id,
    b.booking_date,
    u.first_name,
    u.last_name,
    p.property_name,
    pay.amount,
    pay.status
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Properties p ON b.property_id = p.property_id
LEFT JOIN Payments pay ON b.booking_id = pay.booking_id
WHERE b.booking_date >= DATE_SUB(NOW(), INTERVAL 6 MONTH)
ORDER BY b.booking_date DESC;


