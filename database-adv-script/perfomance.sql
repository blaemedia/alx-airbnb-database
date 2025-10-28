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


-- Step 2: Analyze query execution plan
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

-- Step 3: Add indexes to improve join and filter performance
CREATE INDEX idx_user_id ON Users(user_id);
CREATE INDEX idx_property_id ON Properties(property_id);
CREATE INDEX idx_booking_user ON Bookings(user_id);
CREATE INDEX idx_booking_property ON Bookings(property_id);
CREATE INDEX idx_payment_booking ON Payments(booking_id);


-- Step 4: Optimized query using WHERE with AND condition
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
  AND pay.status = 'Completed'
ORDER BY b.booking_date DESC;


-- Step 5: Run EXPLAIN again to confirm optimization
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
  AND pay.status = 'Completed'
ORDER BY b.booking_date DESC;



