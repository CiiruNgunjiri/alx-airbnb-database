-- Enable UUID extension (run once)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Clear existing data to avoid duplicates and FK conflicts
TRUNCATE TABLE message, review, payment, booking, properties, users CASCADE;

-- USERS
INSERT INTO users (first_name, last_name, email, password_hash, phone_number, role)
VALUES
  ('Alice',   'Mwangi',  'alice@example.com',   'hash1', '+254700000001', 'host'),
  ('Brian',   'Otieno',  'brian@example.com',   'hash2', '+254700000002', 'guest'),
  ('Cynthia', 'Kariuki', 'cynthia@example.com', 'hash3', '+254700000003', 'guest'),
  ('David',   'Mutiso',  'david@example.com',   'hash4', '+254700000004', 'host'),
  ('Eve',     'Wanjiru', 'eve@example.com',     'hash5', '+254700000005', 'admin');

-- PROPERTIES (owned by Alice and David)
INSERT INTO properties (host_id, name, description, location, price_per_night)
SELECT u.user_id, 'Cozy Nairobi Apartment', 'Lovely apartment in Nairobi city center.', 'Nairobi', 100
FROM users u WHERE u.first_name = 'Alice';

INSERT INTO properties (host_id, name, description, location, price_per_night)
SELECT u.user_id, 'Beachfront Villa', 'Luxury villa with ocean views.', 'Mombasa', 300
FROM users u WHERE u.first_name = 'David';

-- Add a second property for Alice
INSERT INTO properties (host_id, name, description, location, price_per_night)
SELECT u.user_id, 'Mountain Cabin', 'Rustic cabin in the mountains.', 'Nairobi', 120
FROM users u WHERE u.first_name = 'Alice';

-- BOOKING (Brian books Alice's apartment, Cynthia books David's villa)
INSERT INTO booking (property_id, user_id, start_date, end_date, total_price, status)
SELECT p.property_id, u.user_id, '2025-07-01', '2025-07-05', p.price_per_night * 4, 'confirmed'
FROM properties p, users u
WHERE p.name = 'Cozy Nairobi Apartment' AND u.first_name = 'Brian';

INSERT INTO booking (property_id, user_id, start_date, end_date, total_price, status)
SELECT p.property_id, u.user_id, '2025-08-10', '2025-08-15', p.price_per_night * 5, 'pending'
FROM properties p, users u
WHERE p.name = 'Beachfront Villa' AND u.first_name = 'Cynthia';

-- PAYMENT (for each booking)
INSERT INTO payment (booking_id, amount, payment_method)
SELECT b.booking_id, b.total_price, 'credit_card'
FROM booking b
JOIN users u ON b.user_id = u.user_id
WHERE u.first_name = 'Brian';

INSERT INTO payment (booking_id, amount, payment_method)
SELECT b.booking_id, b.total_price, 'paypal'
FROM booking b
JOIN users u ON b.user_id = u.user_id
WHERE u.first_name = 'Cynthia';

-- REVIEW (Brian reviews Alice's apartment, Cynthia reviews David's villa)
INSERT INTO review (property_id, user_id, rating, comment)
SELECT p.property_id, u.user_id, 5, 'Fantastic stay, highly recommended!'
FROM properties p, users u
WHERE p.name = 'Cozy Nairobi Apartment' AND u.first_name = 'Brian';

INSERT INTO review (property_id, user_id, rating, comment)
SELECT p.property_id, u.user_id, 4, 'Great location and very clean.'
FROM properties p, users u
WHERE p.name = 'Beachfront Villa' AND u.first_name = 'Cynthia';

-- MESSAGE (Brian sends message to Alice, Cynthia sends to David)
INSERT INTO message (sender_id, recipient_id, message_body)
SELECT s.user_id, r.user_id, 'Hi Alice, is your apartment available for early check-in?'
FROM users s, users r
WHERE s.first_name = 'Brian' AND r.first_name = 'Alice';

INSERT INTO message (sender_id, recipient_id, message_body)
SELECT s.user_id, r.user_id, 'Hi David, can you recommend local restaurants?'
FROM users s, users r
WHERE s.first_name = 'Cynthia' AND r.first_name = 'David';


