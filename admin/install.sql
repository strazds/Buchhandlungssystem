-- CREATE DATABASE bookstore_system;
-- GO

-- Zur Datenbank wechseln
USE bookstore_system;
GO

-- Create the Author table
CREATE TABLE author (
    authorid INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255) NOT NULL,
    birthdate DATE
);

-- Create the Publisher table
CREATE TABLE publisher (
    publisherid INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255)
);

-- Create the Book table
CREATE TABLE book (
    isbn VARCHAR(20) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    edition INT,
    price DECIMAL(10,2),
    publicationdate DATE,
    description TEXT,
    authorid INT NOT NULL,
    publisherid INT NOT NULL,
    FOREIGN KEY (authorid) REFERENCES author(authorid),
    FOREIGN KEY (publisherid) REFERENCES publisher(publisherid)
);

-- Create the Customer table
CREATE TABLE customer (
    customerid INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    email VARCHAR(255) UNIQUE
);

-- Create the Order table
CREATE TABLE [order] (
    orderid INT PRIMARY KEY IDENTITY(1,1),
    orderdate DATETIME,
    shippingaddress VARCHAR(255),
    customerid INT NOT NULL,
    FOREIGN KEY (customerid) REFERENCES customer(customerid)
);

-- Create the OrderItem table
CREATE TABLE orderitem (
    orderitemid INT PRIMARY KEY IDENTITY(1,1),
    orderid INT NOT NULL,
    isbn VARCHAR(20) NOT NULL,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (orderid) REFERENCES [order](orderid),
    FOREIGN KEY (isbn) REFERENCES book(isbn)
);

-- Create the Inventory table
CREATE TABLE inventory (
    inventoryid INT PRIMARY KEY IDENTITY(1,1),
    isbn VARCHAR(20) NOT NULL,
    quantity INT,
    FOREIGN KEY (isbn) REFERENCES book(isbn)
);