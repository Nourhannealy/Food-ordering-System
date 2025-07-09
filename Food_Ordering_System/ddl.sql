--create database Food_Ordering_System;
-- Drop tables in reverse dependency order
IF OBJECT_ID('dbo.Order_items', 'U') IS NOT NULL DROP TABLE dbo.Order_items;
IF OBJECT_ID('dbo.Feedback', 'U') IS NOT NULL DROP TABLE dbo.Feedback;
IF OBJECT_ID('dbo.Order_', 'U') IS NOT NULL DROP TABLE dbo.Order_;
IF OBJECT_ID('dbo.customer_favorites', 'U') IS NOT NULL DROP TABLE dbo.customer_favorites;
IF OBJECT_ID('dbo.Menu_items', 'U') IS NOT NULL DROP TABLE dbo.Menu_items;
IF OBJECT_ID('dbo.Admin_phones', 'U') IS NOT NULL DROP TABLE dbo.Admin_phones; -- 🔧 Add this
IF OBJECT_ID('dbo.Admin', 'U') IS NOT NULL DROP TABLE dbo.Admin;
IF OBJECT_ID('dbo.Customer_phones', 'U') IS NOT NULL DROP TABLE dbo.Customer_phones;
IF OBJECT_ID('dbo.Customer', 'U') IS NOT NULL DROP TABLE dbo.Customer;
IF OBJECT_ID('dbo.Branches', 'U') IS NOT NULL DROP TABLE dbo.Branches;

go 

CREATE TABLE Branches
(
  branch_id INT NOT NULL IDENTITY(1,1),
  location VARCHAR(255) NOT NULL,
  PRIMARY KEY (branch_id)
);

go

CREATE TABLE Customer
(
  customer_id INT IDENTITY(1,1) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  address VARCHAR(255) NOT NULL,
  customer_name VARCHAR(255) NOT NULL,
  PRIMARY KEY (customer_id)
);

go

CREATE TABLE Customer_phones
(
  phone VARCHAR(15) NOT NULL,
  customer_id INT NOT NULL,
  PRIMARY KEY (phone, customer_id),
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE
);

go

CREATE TABLE Admin
(
  admin_id INT NOT NULL IDENTITY(1,1),
  admin_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  branch_id INT,
  PRIMARY KEY (admin_id),
  FOREIGN KEY (branch_id) REFERENCES Branches(branch_id) ON DELETE SET NULL
);

go

CREATE TABLE Admin_phones
(
  phone VARCHAR(15) NOT NULL,
  admin_id INT NOT NULL,
  PRIMARY KEY (phone, admin_id),
  FOREIGN KEY (admin_id) REFERENCES Admin(admin_id) ON DELETE CASCADE
);
go

CREATE TABLE Menu_items
(
  meal_id INT NOT NULL IDENTITY(1,1),
  category VARCHAR(50) NOT NULL,
  season VARCHAR(50) NOT NULL,
  is_available CHAR(1) NOT NULL,  -- 'Y' or 'N'
  price REAL NOT NULL,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(500) NOT NULL,
  admin_id INT,
  PRIMARY KEY (meal_id),
  FOREIGN KEY (admin_id) REFERENCES Admin(admin_id) ON DELETE SET NULL
);


go


CREATE TABLE customer_favorites
(
  customer_id INT NOT NULL,
  meal_id INT NOT NULL,
  PRIMARY KEY (customer_id, meal_id),
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE,
  FOREIGN KEY (meal_id) REFERENCES Menu_items(meal_id) ON DELETE CASCADE
);

go

CREATE TABLE Order_
(
  order_id INT NOT NULL IDENTITY(1,1),
  date DATE NOT NULL,
  total REAL NOT NULL,
  tax REAL NOT NULL,
  payment_method VARCHAR(50) NOT NULL,
  sub_total FLOAT NOT NULL,
  branch_id INT,
  customer_id INT NOT NULL,
  PRIMARY KEY (order_id),
  FOREIGN KEY (branch_id) REFERENCES Branches(branch_id) ON DELETE SET NULL,
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE
);

go


CREATE TABLE Feedback
(
  feedback_id INT NOT NULL IDENTITY(1,1),
  data VARCHAR(255) NOT NULL,
  rate INT NOT NULL,
  review VARCHAR(500) NOT NULL,
  customer_id INT NOT NULL,
  PRIMARY KEY (feedback_id),
  FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE
);


go

CREATE TABLE Order_items
(
  Quantity INT NOT NULL,
  product_total REAL NOT NULL,
  order_id INT NOT NULL,
  meal_id INT NOT NULL,
  PRIMARY KEY (order_id, meal_id),
  FOREIGN KEY (order_id) REFERENCES Order_(order_id) ON DELETE CASCADE,
  FOREIGN KEY (meal_id) REFERENCES Menu_items(meal_id) ON DELETE CASCADE
);

go

--------------------------------- Test ------------------------------



INSERT INTO Branches (location)
VALUES ('Downtown');

go

select location from branches


INSERT INTO Customer (email, password, address, customer_name)
VALUES ('customer@example.com', 'password123', '123 Street, City', 'Ahmed Ali');

go  


insert into Admin(admin_name,email,password,branch_id)
VALUES('ahmed','admin@example.com','password123',1);


go


INSERT INTO Menu_items (category, season, is_available, price, name, description, admin_id)
VALUES ('Main Course', 'Winter', 'Y', 10.99, 'Pizza', 'Delicious cheese pizza', 1);

go


INSERT INTO Order_ (date, total, tax, payment_method, sub_total, branch_id, customer_id)
VALUES ('2025-05-16', 15.00, 1.50, 'Credit Card', 13.50, 1, 1);

go

select * from order_



INSERT INTO Feedback (data, rate, review, customer_id)
VALUES ('2025-05-16', 5, 'Great food!', 1);


go

-- select * from  feedback

-- INSERT INTO Order_items (Quantity, product_total, order_id, meal_id) -- Insertion failed in meal_id
-- VALUES (1, 10.99, 1, 2);  -- 1 Pizza ordered


-- go


---------------------------- Insert sample data -----------------------------------------------




INSERT INTO Branches (location)
VALUES 
('Downtown'), ('City Center'), ('North Zone'), ('West Bay'), ('East End'),
('Green District'), ('Tech Park'), ('Old Town'), ('Marina'), ('Airport Road');




go

INSERT INTO Customer (email, password, address, customer_name)
VALUES 
('ali1@example.com', 'pass1', '123 Main St', 'Ali Mohammed'),
('sara2@example.com', 'pass2', '456 Side St', 'Sara Ahmed'),
('khalid3@example.com', 'pass3', '789 North Ave', 'Khalid Hassan'),
('noor4@example.com', 'pass4', '321 West Blvd', 'Noor Ibrahim'),
('reem5@example.com', 'pass5', '654 Central St', 'Reem Adel'),
('tariq6@example.com', 'pass6', '987 East Dr', 'Tariq Saad'),
('mona7@example.com', 'pass7', '741 Tech Blvd', 'Mona Sami'),
('fahad8@example.com', 'pass8', '852 Garden St', 'Fahad Talal'),
('huda9@example.com', 'pass9', '963 Creek Rd', 'Huda Waleed'),
('noura10@example.com', 'pass10', '159 Airport Rd', 'Noura Fathi');



go
INSERT INTO Customer_phones (phone, customer_id)
VALUES 
('0501111111', 1), ('0502222222', 2), ('0503333333', 2),('01032421359',3),
('0504444444', 4), ('0505555555', 5), ('0506666666', 6),
('0507777777', 7), ('0508888888', 8), ('0509999999', 9), ('0510000000', 10);


go


INSERT INTO Admin (admin_name, email, password, branch_id)
VALUES 
('ahmed aly', 'ahmed@food.com', 'adminpass1', 1),
('amira mahmoud', 'amira@food.com', 'adminpass2', 6),
('mohamed khaled', 'khaled@food.com', 'adminpass3', 3),
('amr mohamed', 'amr@food.com', 'adminpass4', 4),
('abdo aly', 'abdo@food.com', 'adminpass5', 5);



go


-- Sample Meals
INSERT INTO Menu_items (category, season, is_available, price, name, description, admin_id)
VALUES
('Main Course', 'Winter', 'Y', 25.00, 'Beef Burger', 'Grilled beef burger with cheese', 1),
('Main Course', 'Summer', 'Y', 20.00, 'Chicken Wrap', 'Tasty chicken wrap with sauce', 6),
('Appetizer', 'All', 'Y', 10.00, 'Fries', 'Crispy french fries', 2),
('Dessert', 'Summer', 'Y', 12.00, 'Ice Cream', 'Vanilla and chocolate mix', 3),
('Drink', 'All', 'Y', 5.00, 'Soda', 'Cold fizzy drink', 4),
('Main Course', 'Winter', 'Y', 30.00, 'Shawarma Plate', 'Beef shawarma with rice', 5),
('Appetizer', 'All', 'Y', 15.00, 'Onion Rings', 'Crispy rings', 6),
('Dessert', 'Winter', 'Y', 18.00, 'Molten Cake', 'Hot chocolate lava cake', 1),
('Drink', 'Summer', 'Y', 8.00, 'Lemonade', 'Fresh lemonade', 2),
('Main Course', 'All', 'Y', 22.00, 'Pizza Margherita', 'Classic cheese pizza', 3);

go

INSERT INTO customer_favorites (customer_id, meal_id)
VALUES 
(1, 1), (1, 3), (1, 6),
(2, 2), (2, 4),
(3, 1), (3, 5),
(4, 3), (4, 6), (4, 7),
(5, 2), (5, 8),
(6, 1), (6, 9),
(7, 4), (7, 10),
(8, 2), (8, 5), (8, 6),
(9, 3), (9, 7),
(10, 1), (10, 8), (10, 10);

go

-- Insert 20 test orders (all within last 2 months)
INSERT INTO Order_ (date, total, tax, payment_method, sub_total, branch_id, customer_id)
VALUES
-- First 7 orders for Pizza Margherita (meal_id 10)
('2025-05-01', 22.00, 2.20, 'Cash', 19.80, 1, 1),
('2025-05-02', 22.00, 2.20, 'Credit', 19.80, 2, 2),
('2025-05-03', 22.00, 2.20, 'Debit', 19.80, 3, 3),
('2025-05-04', 22.00, 2.20, 'Cash', 19.80, 4, 4),
('2025-05-05', 22.00, 2.20, 'Online', 19.80, 5, 5),
('2025-05-06', 22.00, 2.20, 'Credit', 19.80, 6, 6),
('2025-05-07', 22.00, 2.20, 'Cash', 19.80, 7, 7),

-- Next 6 orders for Beef Burger (meal_id 1)
('2025-05-08', 25.00, 2.50, 'Cash', 22.50, 1, 1),
('2025-05-09', 25.00, 2.50, 'Credit', 22.50, 2, 2),
('2025-05-10', 25.00, 2.50, 'Debit', 22.50, 3, 3),
('2025-05-11', 25.00, 2.50, 'Cash', 22.50, 4, 4),
('2025-05-12', 25.00, 2.50, 'Online', 22.50, 5, 5),
('2025-05-13', 25.00, 2.50, 'Credit', 22.50, 6, 6),

-- 5 orders for Fries (meal_id 3) - should NOT appear in results
('2025-05-14', 10.00, 1.00, 'Cash', 9.00, 1, 1),
('2025-05-15', 10.00, 1.00, 'Credit', 9.00, 2, 2),
('2025-05-16', 10.00, 1.00, 'Debit', 9.00, 3, 3),
('2025-05-17', 10.00, 1.00, 'Cash', 9.00, 4, 4),
('2025-05-18', 10.00, 1.00, 'Online', 9.00, 5, 5),

-- 2 orders for Chicken Wrap (meal_id 2) - should NOT appear
('2025-05-19', 20.00, 2.00, 'Cash', 18.00, 1, 1),
('2025-05-20', 20.00, 2.00, 'Credit', 18.00, 2, 2);

 go

 -- Insert order items matching the orders above
INSERT INTO Order_items (Quantity, product_total, order_id, meal_id)
VALUES
-- Pizza Margherita orders (7)
(1, 22.00, 1, 10),
(1, 22.00, 2, 10),
(1, 22.00, 3, 10),
(1, 22.00, 4, 10),
(1, 22.00, 5, 10),
(1, 22.00, 6, 10),
(1, 22.00, 7, 10),

-- Beef Burger orders (6)
(1, 25.00, 8, 1),
(1, 25.00, 9, 1),
(1, 25.00, 10, 1),
(1, 25.00, 11, 1),
(1, 25.00, 12, 1),
(1, 25.00, 13, 1),

-- Fries orders (5)
(1, 10.00, 14, 3),
(1, 10.00, 15, 3),
(1, 10.00, 16, 3),
(1, 10.00, 17, 3),
(1, 10.00, 18, 3),

-- Chicken Wrap orders (2)
(1, 20.00, 19, 2),
(1, 20.00, 20, 2);
go
INSERT INTO Feedback ( data, rate, review, customer_id)
VALUES
( '2025-05-16', 5, 'The food was absolutely amazing. Will order again!', 1),
( '2025-05-16', 4, 'Great taste, but the fries were a bit cold.', 2),
( '2025-05-17', 3, 'It was okay, delivery took longer than expected.', 3),
( '2025-05-17', 2, 'Poor packaging and late delivery.', 4),
( '2025-05-18', 5, 'Excellent service! Friendly delivery guy.', 5);


INSERT INTO Admin_phones (admin_id, phone)
VALUES
(1, '6841236'),
(2, '1234567'),
(3, '2345678'),
(4, '3456789'),
(5, '4567891'),
(5, '5678912'),
(6, '6789123');
go
----------------------------- show all columns ------------------
select * from Branches
select * from Customer
select * from Customer_phones
select *from Admin
select * from customer_favorites
select *from Feedback
select*from Order_items
select * from Order_
select *from Menu_items
select *from Admin_phones

