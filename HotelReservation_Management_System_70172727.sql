CREATE DATABASE HotelReservationManagementSystem;
USE HotelReservationManagementSystem;

            -- Person (supertyp)--
CREATE TABLE Person (
    person_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    house_no VARCHAR(20),
    street VARCHAR(50),
    city VARCHAR(50),
    postal_code VARCHAR(10)
);
           -- Person_Phone multivalued attribut--
CREATE TABLE Person_Phone (
    phone_id INT AUTO_INCREMENT PRIMARY KEY,
    person_id INT,
    phone_number VARCHAR(20),
    FOREIGN KEY (person_id) REFERENCES Person(person_id)
);
         -- customer (ISA from Person)--
CREATE TABLE Customer (
    person_id INT PRIMARY KEY,
    loyalty_points INT DEFAULT 0,
    registration_date DATE,
    FOREIGN KEY (person_id) REFERENCES Person(person_id)
);
     --   employee (ISA from Person)
CREATE TABLE Employee (
    person_id INT PRIMARY KEY,
    role VARCHAR(50),
    salary DECIMAL(10,2),
    shift_time VARCHAR(50),
    FOREIGN KEY (person_id) REFERENCES Person(person_id)
);
               -- hotel--
CREATE TABLE Hotel (
    hotel_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100),
    contact_no VARCHAR(20),
    ratings DECIMAL(2,1)
);
            -- room_type--
CREATE TABLE Room_Type (
    room_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50),
    price_per_night DECIMAL(10,2)
);
           -- room--
CREATE TABLE Room (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10),
    status VARCHAR(20),
    hotel_id INT,
    room_type_id INT,
    FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id),
    FOREIGN KEY (room_type_id) REFERENCES Room_Type(room_type_id)
);
          -- reservation--
CREATE TABLE Reservation (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    check_in_date DATE,
    check_out_date DATE,
    total_amount DECIMAL(10,2),
    customer_id INT,
    room_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(person_id),
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
);
          -- payment--
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_date DATE,
    payment_method VARCHAR(50),
    amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    reservation_id INT,
    FOREIGN KEY (reservation_id) REFERENCES Reservation(reservation_id)
);
           -- service--
CREATE TABLE Service (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100),
    service_price DECIMAL(10,2),
    description VARCHAR(255)
);
              -- room_ service--
CREATE TABLE Room_Service (
    reservation_id INT,
    service_id INT,
    quantity INT,
    PRIMARY KEY (reservation_id, service_id),
    FOREIGN KEY (reservation_id) REFERENCES Reservation(reservation_id),
    FOREIGN KEY (service_id) REFERENCES Service(service_id)
);
	         -- feedback--
CREATE TABLE Feedback (
    feedback_id INT AUTO_INCREMENT,
    reservation_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment VARCHAR(255),
    feedback_date DATE,
    PRIMARY KEY (feedback_id, reservation_id),
    FOREIGN KEY (reservation_id) REFERENCES Reservation(reservation_id)
);
          -- sample Data--
           --   person--
INSERT INTO Person (name,email,house_no,street,city,postal_code) VALUES
('Saad sarfraz','saadsarfraz@gmail.com','12','Model Town','Lahore','54000'),
('Shayan Arshad','shayan@gmail.com','22','DHA','Lahore','54010'),
('zainab Ali','zainab@gmail.com','9','Johar Town','Lahore','54700'),
('zara Noor','zara@gmail.com','44','Cantt','Lahore','54800'),
('sarah Raza','sarah@gmail.com','18','Gulberg','Lahore','54660');
               -- Customer--
INSERT INTO Customer VALUES
(1,200,'2024-01-01'),
(2,150,'2024-02-01'),
(3,100,'2024-03-01'),
(4,80,'2024-04-01'),
(5,50,'2024-05-01');
                   -- Employee--
INSERT INTO Employee VALUES
(1,'Manager',90000,'Morning'),
(2,'Receptionist',40000,'Evening'),
(3,'Cleaner',25000,'Night'),
(4,'Chef',60000,'Morning'),
(5,'Security',30000,'Night');
                  -- Hotel--

INSERT INTO Hotel (name,location,contact_no,ratings) VALUES
('Pearl Continental','Lahore','042111505505',4.8),
('Avari','Lahore','042111282747',4.5),
('Nishat','Lahore','04235761999',4.6),
('Luxus','Lahore','04211158987',4.7),
('Faletti','Lahore','042111400400',4.4);
                    -- Room_Type--

INSERT INTO Room_Type (type_name,price_per_night) VALUES
('Single',8000),
('Double',12000),
('Deluxe',18000),
('Suite',25000),
('Executive',30000);
                            -- Room--

INSERT INTO Room (room_number,status,hotel_id,room_type_id) VALUES
('101','Available',1,1),
('102','Available',1,2),
('201','Reserved',2,3),
('301','Available',3,4),
('401','Reserved',4,5);
                          -- Reservation --

INSERT INTO Reservation (check_in_date,check_out_date,total_amount,customer_id,room_id) VALUES
('2025-01-10','2025-01-12',16000,1,1),
('2025-01-15','2025-01-18',36000,2,2),
('2025-01-20','2025-01-23',54000,3,3),
('2025-01-25','2025-01-28',75000,4,4),
('2025-02-01','2025-02-05',120000,5,5);
                          -- Payment--

INSERT INTO Payment VALUES
(1,'2025-01-12','Card',16000,'Paid',1),
(2,'2025-01-18','Cash',36000,'Paid',2),
(3,'2025-01-23','Card',54000,'Paid',3),
(4,'2025-01-28','Online',75000,'Paid',4),
(5,'2025-02-05','Card',120000,'Paid',5);
                      -- Service--

INSERT INTO Service (service_name,service_price,description) VALUES
('Room Cleaning',2000,'Daily cleaning'),
('Laundry',1500,'Clothes washing'),
('Breakfast',2500,'Buffet breakfast'),
('Spa',5000,'Relaxation spa'),
('Airport Pickup',4000,'Transport service');
                     -- Room_Service--

INSERT INTO Room_Service VALUES
(1,1,1),
(1,3,2),
(2,2,1),
(3,4,1),
(4,5,1);
                             -- Feedback --

INSERT INTO Feedback VALUES
(1,1,5,'Excellent stay','2025-01-12'),
(2,2,4,'Very good','2025-01-18'),
(3,3,5,'Amazing service','2025-01-23'),
(4,4,4,'Comfortable','2025-01-28'),
(5,5,5,'Luxury experience','2025-02-05');

          --   COMPLEX SQL QUERIES --

          -- Show all available rooms--
SELECT * 
FROM Room
WHERE status = 'Available';

             -- Display customers with Gmail accounts--
SELECT person_id, name, email
FROM Person
WHERE email LIKE '%@gmail.com';
          
                 -- JOIN Query--

SELECT p.name, r.reservation_id, ro.room_number
FROM Person p
JOIN Customer c ON p.person_id = c.person_id
JOIN Reservation r ON c.person_id = r.customer_id
JOIN Room ro ON r.room_id = ro.room_id;
          -- show multi join reservation+coustmor+ room--- 
SELECT p.name AS customer_name,
       h.name AS hotel_name,
       ro.room_number
FROM Reservation r
JOIN Customer c ON r.customer_id = c.person_id
JOIN Person p ON c.person_id = p.person_id
JOIN Room ro ON r.room_id = ro.room_id
JOIN Hotel h ON ro.hotel_id = h.hotel_id;
            -- Show feedback only for reserved rooms-
SELECT f.feedback_id, f.rating, f.comment
FROM Feedback f
INNER JOIN Reservation r
ON f.reservation_id = r.reservation_id;
                 -- Aggregate Query-- 
                 
                 -- count--
SELECT COUNT(*) AS total_reservations FROM Reservation;

               -- group By sum --
SELECT hotel_id, COUNT(room_id) AS total_rooms
FROM Room
GROUP BY hotel_id;

               -- Avg price--
SELECT AVG(price_per_night) AS avg_room_price FROM Room_Type;

                  -- (Top Paying Customers)--
SELECT customer_id, total_amount
FROM Reservation
WHERE total_amount > (
    SELECT AVG(total_amount) FROM Reservation
);

                  -- Many-to-Many Service Cost--
SELECT r.reservation_id,
       SUM(rs.quantity * s.service_price) AS service_cost
FROM Room_Service rs
JOIN Service s ON rs.service_id = s.service_id
JOIN Reservation r ON rs.reservation_id = r.reservation_id
GROUP BY r.reservation_id;

