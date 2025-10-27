# 🎯 Objective
**Master SQL joins by writing complex queries using different types of joins.**

---

## 🧾 Instructions

1. Write a query using an **INNER JOIN** to retrieve all bookings and the respective users who made those bookings.  
2. Write a query using a **LEFT JOIN** to retrieve all properties and their reviews, including properties that have no reviews.  
3. Write a query using a **FULL OUTER JOIN** to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

---

## 🧱 Sample Database Schema

```sql
-- USERS table
users(
  user_id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100)
);

-- BOOKINGS table
bookings(
  booking_id INT PRIMARY KEY,
  user_id INT,
  property_id INT,
  booking_date DATE,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- PROPERTIES table
properties(
  property_id INT PRIMARY KEY,
  property_name VARCHAR(100),
  location VARCHAR(100)
);

-- REVIEWS table
reviews(
  review_id INT PRIMARY KEY,
  property_id INT,
  user_id INT,
  rating INT,
  comment TEXT
);



SELECT 
    b.booking_id,
    b.property_id,
    b.booking_date,
    u.user_id,
    u.name AS user_name,
    u.email AS user_email
FROM 
    bookings AS b
INNER JOIN 
    users AS u
ON 
    b.user_id = u.user_id;


SELECT 
    p.property_id,
    p.property_name,
    p.location,
    r.review_id,
    r.rating,
    r.comment
FROM 
    properties AS p
LEFT JOIN 
    reviews AS r
ON 
    p.property_id = r.property_id;


SELECT 
    p.property_id,
    p.property_name,
    p.location,
    r.review_id,
    r.rating,
    r.comment
FROM 
    properties AS p
LEFT JOIN 
    reviews AS r
ON 
    p.property_id = r.property_id;

SELECT 
    u.user_id,
    u.name AS user_name,
    b.booking_id,
    b.property_id,
    b.booking_date
FROM 
    users AS u
FULL OUTER JOIN 
    bookings AS b
ON 
    u.user_id = b.user_id;


SELECT 
    u.user_id,
    u.name AS user_name,
    b.booking_id,
    b.property_id,
    b.booking_date
FROM users AS u
LEFT JOIN bookings AS b ON u.user_id = b.user_id

UNION

SELECT 
    u.user_id,
    u.name AS user_name,
    b.booking_id,
    b.property_id,
    b.booking_date
FROM users AS u
RIGHT JOIN bookings AS b ON u.user_id = b.user_id;
