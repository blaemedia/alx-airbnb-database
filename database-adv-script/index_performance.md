##
 ===========================================
 DATABASE SCHEMA DEFINITION 
 File: database_index.sql
===========================================

=====================
USER TABLE
=====================

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================
-- PROPERTY TABLE
-- =====================
CREATE TABLE properties (
    id SERIAL PRIMARY KEY,
    owner_id INT REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(150) NOT NULL,
    location VARCHAR(150),
    price DECIMAL(10,2),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================
-- BOOKING TABLE
-- =====================

CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    property_id INT REFERENCES properties(id) ON DELETE CASCADE,
    booking_date DATE NOT NULL,
    status VARCHAR(50) CHECK (status IN ('pending', 'confirmed', 'cancelled')),
    total_amount DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===========================================
-- INDEX CREATION
-- ===========================================

-- USER TABLE INDEXES
CREATE INDEX idx_user_email ON users(email);
CREATE INDEX idx_user_created_at ON users(created_at);

-- PROPERTY TABLE INDEXES
CREATE INDEX idx_property_location ON properties(location);
CREATE INDEX idx_property_price ON properties(price);
CREATE INDEX idx_property_created_at ON properties(created_at);

-- BOOKING TABLE INDEXES
CREATE INDEX idx_booking_user_id ON bookings(user_id);
CREATE INDEX idx_booking_property_id ON bookings(property_id);
CREATE INDEX idx_booking_date ON bookings(booking_date);
CREATE INDEX idx_booking_status ON bookings(status);

-- COMPOSITE INDEXES FOR COMMON FILTERS
CREATE INDEX idx_booking_status_date ON bookings(status, booking_date);
CREATE INDEX idx_property_location_price ON properties(location, price);




-- Sample Query Before Index
EXPLAIN ANALYZE
SELECT 
    b.id, b.booking_date, b.status, 
    u.name AS user_name, 
    p.title AS property_title
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
WHERE b.status = 'confirmed'
  AND p.location = 'Lagos'
ORDER BY b.booking_date DESC;


-- Sample Query Before Index
EXPLAIN ANALYZE
SELECT 
    b.id, b.booking_date, b.status, 
    u.name AS user_name, 
    p.title AS property_title
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
WHERE b.status = 'confirmed'
  AND p.location = 'Lagos'
ORDER BY b.booking_date DESC;

ANALYZE;

