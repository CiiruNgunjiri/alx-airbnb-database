
-- USERS
INSERT INTO USERS (FIRST_NAME, LAST_NAME, EMAIL, PASSWORD_HASH, PHONE_NUMBER, ROLE)
VALUES
  ('Alice',   'Mwangi',  'alimwangi@example.com',   'hash1', '+254700000001', 'host'),
  ('Brian',   'Otieno',  'brian@example.com',   'hash2', '+254700000002', 'guest'),
  ('Cynthia', 'Kariuki', 'cynthia@example.com', 'hash3', '+254700000003', 'guest'),
  ('David',   'Mutiso',  'david@example.com',   'hash4', '+254700000004', 'admin'),
  ('Eve',     'Wanjiru', 'eve@example.com',     'hash5', '+254700000005', 'admin');

-- PROPERTIES (owned by Alice and David)
INSERT INTO PROPERTIES (HOST_ID, NAME, DESCRIPTION, PRICE_PER_NIGHT)
SELECT U.USER_ID, 'Cozy Nairobi Apartment', 'Lovely apartment in Nairobi city center.', 100
FROM USERS U WHERE U.FIRST_NAME = 'Alice';

INSERT INTO PROPERTIES (HOST_ID, NAME, DESCRIPTION, PRICE_PER_NIGHT)
SELECT U.USER_ID, 'Beachfront Villa', 'Luxury villa with ocean views.', 300
FROM USERS U WHERE U.FIRST_NAME = 'David';

-- Add a second property for Alice
INSERT INTO PROPERTIES (HOST_ID, NAME, DESCRIPTION, PRICE_PER_NIGHT)
SELECT U.USER_ID, 'Mountain Cabin', 'Rustic cabin in the mountains.', 120
FROM USERS U WHERE U.FIRST_NAME = 'Alice';

-- BOOKING (Brian books Alice's apartment, Cynthia books David's villa)
INSERT INTO BOOKING (PROPERTY_ID, USER_ID, START_DATE, END_DATE, TOTAL_PRICE, STATUS)
SELECT P.PROPERTY_ID, U.USER_ID, '2025-07-01', '2025-07-05', 400, 'CONFIRMED'
FROM PROPERTIES P, USERS U
WHERE P.NAME = 'Cozy Nairobi Apartment' AND U.FIRST_NAME = 'Brian';

INSERT INTO BOOKING (PROPERTY_ID, USER_ID, START_DATE, END_DATE, TOTAL_PRICE, STATUS)
SELECT P.PROPERTY_ID, U.USER_ID, '2025-08-10', '2025-08-15', 1500, 'PENDING'
FROM PROPERTIES P, USERS U
WHERE P.NAME = 'Beachfront Villa' AND U.FIRST_NAME = 'Cynthia';

-- PAYMENT (for each booking)
INSERT INTO PAYMENT (BOOKING_ID, AMOUNT, PAYMENT_DATE, PAYMENT_METHOD)
SELECT B.BOOKING_ID, B.TOTAL_PRICE, CURRENT_TIMESTAMP, 'CREDIT_CARD'
FROM BOOKING B
JOIN USERS U ON B.USER_ID = U.USER_ID
WHERE U.FIRST_NAME = 'Brian';

INSERT INTO PAYMENT (BOOKING_ID, AMOUNT, PAYMENT_DATE, PAYMENT_METHOD)
SELECT B.BOOKING_ID, B.TOTAL_PRICE, CURRENT_TIMESTAMP, 'PAYPAL'
FROM BOOKING B
JOIN USERS U ON B.USER_ID = U.USER_ID
WHERE U.FIRST_NAME = 'Cynthia';

-- REVIEW (Brian reviews Alice's apartment, Cynthia reviews David's villa)
INSERT INTO REVIEW (PROPERTY_ID, USER_ID, RATING, COMMENT)
SELECT P.PROPERTY_ID, U.USER_ID, 5, 'Fantastic stay, highly recommended!'
FROM PROPERTIES P, USERS U
WHERE P.NAME = 'Cozy Nairobi Apartment' AND U.FIRST_NAME = 'Brian';

INSERT INTO REVIEW (PROPERTY_ID, USER_ID, RATING, COMMENT)
SELECT P.PROPERTY_ID, U.USER_ID, 4, 'Great location and very clean.'
FROM PROPERTIES P, USERS U
WHERE P.NAME = 'Beachfront Villa' AND U.FIRST_NAME = 'Cynthia';

-- MESSAGE (Brian sends message to Alice, Cynthia sends to David)
INSERT INTO MESSAGE (SENDER_ID, RECIPIENT_ID, MESSAGE_BODY)
SELECT S.USER_ID, R.USER_ID, 'Hi Alice, is your apartment available for early check-in?'
FROM USERS S, USERS R
WHERE S.FIRST_NAME = 'Brian' AND R.FIRST_NAME = 'Alice';

INSERT INTO MESSAGE (SENDER_ID, RECIPIENT_ID, MESSAGE_BODY)
SELECT S.USER_ID, R.USER_ID, 'Hi David, can you recommend local restaurants?'
FROM USERS S, USERS R
WHERE S.FIRST_NAME = 'Cynthia' AND R.FIRST_NAME = 'David';

