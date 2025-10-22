# 🌱 Database Seeding — Airbnb Clone

## 🎯 Objective
Add realistic sample data to populate the Airbnb database schema for testing and demonstration purposes.

---

## 🧍‍♂️ Table: User

```sql
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
('11111111-1111-1111-1111-111111111111', 'John', 'Doe', 'john.doe@example.com', 'hashedpassword123', '+2348012345678', 'guest', NOW()),
('22222222-2222-2222-2222-222222222222', 'Jane', 'Smith', 'jane.smith@example.com', 'securepass456', '+2348098765432', 'host', NOW()),
('33333333-3333-3333-3333-333333333333', 'Admin', 'User', 'admin@airbnbclone.com', 'adminpass789', '+2347001122334', 'admin', NOW());

INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES
('44444444-4444-4444-4444-444444444444', '22222222-2222-2222-2222-222222222222', 'Cozy Apartment', 'A beautiful two-bedroom apartment with a balcony view.', 'Lagos, Nigeria', 35000.00, NOW(), NOW()),
('55555555-5555-5555-5555-555555555555', '22222222-2222-2222-2222-222222222222', 'Beachside Villa', 'Luxury villa near the ocean with pool and Wi-Fi.', 'Lekki, Lagos', 85000.00, NOW(), NOW());


INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
('66666666-6666-6666-6666-666666666666', '44444444-4444-4444-4444-444444444444', '11111111-1111-1111-1111-111111111111', '2025-11-01', '2025-11-05', 140000.00, 'confirmed', NOW()),
('77777777-7777-7777-7777-777777777777', '55555555-5555-5555-5555-555555555555', '11111111-1111-1111-1111-111111111111', '2025-12-10', '2025-12-15', 425000.00, 'pending', NOW());


INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
('88888888-8888-8888-8888-888888888888', '66666666-6666-6666-6666-666666666666', 140000.00, NOW(), 'credit_card'),
('99999999-9999-9999-9999-999999999999', '77777777-7777-7777-7777-777777777777', 425000.00, NOW(), 'paypal');


INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
VALUES
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '44444444-4444-4444-4444-444444444444', '11111111-1111-1111-1111-111111111111', 5, 'Fantastic place! The host was super helpful.', NOW()),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '55555555-5555-5555-5555-555555555555', '11111111-1111-1111-1111-111111111111', 4, 'Beautiful villa, but the Wi-Fi was slow.', NOW());

INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
('cccccccc-cccc-cccc-cccc-cccccccccccc', '11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', 'Hi, is your villa available for the weekend?', NOW()),
('dddddddd-dddd-dddd-dddd-dddddddddddd', '22222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 'Yes! It’s available from Friday to Sunday.', NOW());
