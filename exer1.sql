CREATE DATABASE company;
USE company;

CREATE TABLE productlines (
  productLine INT NOT NULL AUTO_INCREMENT,
  textDescription VARCHAR(50) NOT NULL,
  htmlDescription TEXT NOT NULL,
  image VARCHAR(150) NOT NULL,
  PRIMARY KEY (productLine)
);

CREATE TABLE payments (
  customerNumber INT NOT NULL AUTO_INCREMENT,
  checkNumber INT NOT NULL UNIQUE,
  paymentDate DATETIME NOT NULL DEFAULT NOW(),
  amount BIGINT NOT NULL,
  PRIMARY KEY (customerNumber),
  FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);

CREATE TABLE offices (
  officeCode INT NOT NULL AUTO_INCREMENT,
  city VARCHAR(50) NOT NULL,
  phone BIGINT(14) NOT NULL,
  addressLine1 VARCHAR(50) NOT NULL,
  addressLine2 VARCHAR(50),
  state VARCHAR(50),
  country VARCHAR(50),
  postalCode VARCHAR(10),
  territory VARCHAR(50),
  PRIMARY KEY (officeCode)
);

CREATE TABLE products (
  productCode INT NOT NULL AUTO_INCREMENT,
  productName VARCHAR(50) NOT NULL,
  productLine INT NOT NULL,
  productScale VARCHAR(50) NOT NULL,
  productVendor VARCHAR(50) NOT NULL,
  productDescription VARCHAR(255),
  quantityInStock INT NOT NULL,
  buyPrice DECIMAL(10, 2) NOT NULL,
  MSRP DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (productCode),
  FOREIGN KEY (productLine) REFERENCES productlines(productLine)
);

CREATE TABLE orderdetails (
  orderNumber INT NOT NULL,
  productCode INT NOT NULL,
  quantityOrdered INT NOT NULL,
  priceEach DECIMAL(10, 2) NOT NULL,
  orderLineNumber INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (orderLineNumber),
  UNIQUE KEY orderNumber_lineNumber (orderNumber, orderLineNumber),
  FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber),
  FOREIGN KEY (productCode) REFERENCES products(productCode)
);

CREATE TABLE orders (
  orderNumber INT NOT NULL AUTO_INCREMENT,
  orderDate DATETIME NOT NULL DEFAULT NOW(),
  requiredDate DATE NOT NULL,
  shippedDate DATE,
  status VARCHAR(50) NOT NULL,
  comments VARCHAR(255),
  customerNumber INT NOT NULL,
  PRIMARY KEY (orderNumber),
  FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);

CREATE TABLE customers (
  customerNumber INT NOT NULL AUTO_INCREMENT,
  customerName VARCHAR(50) NOT NULL,
  contactLastName VARCHAR(50) NOT NULL,
  contactFirstName VARCHAR(50) NOT NULL,
  phone BIGINT(19) NOT NULL,
  addressLine1 VARCHAR(150) NOT NULL,
  addressLine2 VARCHAR(150),
  city VARCHAR(50) NOT NULL,
  state VARCHAR(50),
  postalCode VARCHAR(20) NOT NULL,
  country VARCHAR(50) NOT NULL,
  salesRepEmployeeNumber INT,
  creditLimit DECIMAL(10, 2),
  PRIMARY KEY (customerNumber),
  FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees(employeeNumber)
);

CREATE TABLE employees (
  employeeNumber INT NOT NULL AUTO_INCREMENT,
  lastName VARCHAR(50) NOT NULL,
  firstName VARCHAR(50) NOT NULL,
  extension VARCHAR(10) NOT NULL,
  email VARCHAR(100) NOT NULL,
  officeCode INT NOT NULL,
  reportsTo INT,
  jobTitle VARCHAR(50) NOT NULL,
  PRIMARY KEY (employeeNumber),
  FOREIGN KEY (officeCode) REFERENCES offices(officeCode),
  FOREIGN KEY (reportsTo) REFERENCES employees(employeeNumber)
);


INSERT INTO productlines (textDescription, htmlDescription, image)
VALUES ('Motos', '<p>Viva a emoção da estrada aberta em uma de nossas motocicletas premium.</p>', 'motos.jpg');

INSERT INTO productlines (textDescription, htmlDescription, image)
VALUES ('Aviões', '<p>Nossa coleção de aviões inclui alguns dos designs mais icônicos e inovadores da história da aviação.</p>', 'avioes.jpg');

INSERT INTO productlines (textDescription, htmlDescription, image)
VALUES ('Navios', '<p>De iates de luxo a poderosos navios de guerra, nossa coleção de navios tem algo para cada entusiasta marítimo.</p>', 'navios.jpg');

INSERT INTO productlines (textDescription, htmlDescription, image)
VALUES ('Trens', '<p>Volte no tempo e experimente a era de ouro das viagens de trem com nossa coleção de locomotivas e vagões de passageiros antigos.</p>', 'trens.jpg');

INSERT INTO productlines (textDescription, htmlDescription, image)
VALUES ('Carros Antigos', '<p>Nossa coleção de carros antigos apresenta alguns dos veículos mais requintados e raros do início do século 20.</p>', 'carros_antigos.jpg');


INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount)
VALUES
 (1001, 1, '2023-03-01', 1000.00),
 (1002, 2, '2023-03-02', 2000.00),
 (1003, 3, '2023-03-03', 3000.00),
 (1004, 4, '2023-03-04', 4000.00),
 (1005, 5, '2023-03-05', 5000.00);


INSERT INTO offices (city, phone, addressLine1, country, postalCode, territory)
VALUES ('San Francisco', 1234567890, '100 Market St', 'USA', '94111', 'NA');

INSERT INTO offices (city, phone, addressLine1, country, postalCode, territory)
VALUES ('Paris', 2345678901, '43 Rue Jouffroy D''abbans', 'France', '75017', 'EMEA');

INSERT INTO offices (city, phone, addressLine1, country, postalCode, territory)
VALUES ('Tokyo', 3456789012, '4-1 Kioicho', 'Japan', '102-8578', 'APAC');

INSERT INTO offices (city, phone, addressLine1, addressLine2, country, postalCode, territory)
VALUES ('Sydney', 4567890123, '5-11 Wentworth Ave', 'Floor #2', 'Australia', 'NSW 2010', 'APAC');

INSERT INTO offices (city, phone, addressLine1, country, postalCode, territory)
VALUES ('London', 5678901234, '25 Old Broad St', 'UK', 'EC2N 1HN', 'EMEA');

ALTER TABLE products MODIFY COLUMN  productDescription VARCHAR(200) NOT NULL;

INSERT INTO products (productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP)
VALUES ('1969 Harley Davidson Ultimate Chopper', 1, 1, 'Min Lin Diecast', 'This replica features working kickstand, front suspension, gear-shift lever', 7933, 4856, 95);

INSERT INTO products (productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP)
VALUES ('1952 Alpine Renault 1300', 1, 1, 'Classic Metal Creations', 'Turnable front wheels; steering function; detailed interior', 7305, 9852, 214);

INSERT INTO products (productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP)
VALUES ('1996 Moto Guzzi 1100i', 1, 1, 'Highway 66 Mini Classics', 'Official Moto Guzzi logos and insignias, saddle bags located on side of motorcycle', 6625, 6821, 118);

INSERT INTO products (productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP)
VALUES ('1993 Mazda RX-7', 2, 1, 'Autoart Studio Design', '1:18 scale die-cast replica of the 1993 Mazda RX-7', 9446, 3975, 83);

INSERT INTO products (productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP)
VALUES ('1937 Lincoln Berline', 3, 1, 'Motor City Art Classics', 'Features opening engine cover, doors, trunk, and fuel filler cap.', 6625, 10230, 170);

INSERT INTO products (productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP)
VALUES ('1957 Ford Thunderbird', 3, 1, 'Min Lin Diecast', 'This 1:18 scale precision die cast replica features the signature portholes', 3209, 3884, 71);

INSERT INTO orderdetails (orderNumber, productCode, quantityOrdered, priceEach)
VALUES (1000, 1, 25, 50),
       (1001, 2, 15, 75),
       (1002, 3, 10, 150),
       (1003, 4, 5, 225),
       (1004, 5, 30, 30);
   
       
INSERT INTO orders (orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber)
VALUES (1000,'2023-03-01 10:00:00', '2023-03-05', '2023-03-03', 'Em trânsito', 'Pedido enviado para entrega', 1001);

INSERT INTO orders (orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber)
VALUES (1001,'2023-03-02 15:30:00', '2023-03-06', '2023-03-04', 'Em trânsito', 'Pedido enviado para entrega', 1002);

INSERT INTO orders (orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber)
VALUES (1002,'2023-03-03 12:15:00', '2023-03-07', '2023-03-05', 'Em trânsito', 'Pedido enviado para entrega', 1003);

INSERT INTO orders (orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber)
VALUES (1003,'2023-03-04 14:30:00', '2023-03-08', '2023-03-06', 'Em trânsito', 'Pedido enviado para entrega', 1004);

INSERT INTO orders (orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber)
VALUES (1004,'2023-03-05 09:45:00', '2023-03-09', '2023-03-07', 'Em trânsito', 'Pedido enviado para entrega', 1005);

INSERT INTO customers (customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit)
VALUES
 (1001, 'Customer 1', 'Lastname1', 'Firstname1', 1111111111, 'Address 1', NULL, 'City 1', 'State 1', 12345678, 'Country 1', 1001, 10000),
 (1002, 'Customer 2', 'Lastname2', 'Firstname2', 2222222222, 'Address 2', NULL, 'City 2', 'State 2', 23456789, 'Country 2', 1002, 20000),
 (1003, 'Customer 3', 'Lastname3', 'Firstname3', 3333333333, 'Address 3', NULL, 'City 3', 'State 3', 34567890, 'Country 3', 1003, 30000),
 (1004, 'Customer 4', 'Lastname4', 'Firstname4', 4444444444, 'Address 4', NULL, 'City 4', 'State 4', 45678901, 'Country 4', 1004, 40000),
 (1005, 'Customer 5', 'Lastname5', 'Firstname5', 5555555555, 'Address 5', NULL, 'City 5', 'State 5', 56789012, 'Country 5', 1005, 50000);

 
INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES
  (1001, 'Silva', 'João', 'x123', 'joao.silva@empresa.com', 1, null, 'Gerente de Vendas'),
  (1002, 'Santos', 'Maria', 'x456', 'maria.santos@empresa.com', 1, 1001, 'Vendedor'),
  (1003, 'Oliveira', 'Pedro', 'x789', 'pedro.oliveira@empresa.com', 2, 1001, 'Vendedor'),
  (1004, 'Costa', 'Ana', 'x234', 'ana.costa@empresa.com', 2, 1003, 'Assistente de Marketing'),
  (1005, 'Rodrigues', 'Carlos', 'x567', 'carlos.rodrigues@empresa.com', 3, 1003, 'Gerente de Marketing');

select * from products p 
join productlines pl on pl.productline = p.productline;

select * from orderdetails o 
join products p on p.productCode = o.productCode;
 
select * from orders os
join orderdetails o on o.orderNumber = os.orderNumber;

select * from offices off
join employees em on em.officeCode = off.officeCode;

select * from customers cus
join employees em on em.employeeNumber = cus.salesRepEmployeeNumber;

select * from orders ord
join customers cus on cus.customerNumber = ord.customerNumber;

select * from payments pay
join customers cus on cus.customerNumber = pay.customerNumber