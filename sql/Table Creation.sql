DROP TABLE IF EXISTS Dim_Date;
GO
CREATE TABLE Dim_Date (
date_sk INT PRIMARY KEY,
full_date DATE NOT NULL,
day_of_month TINYINT NOT NULL , 
day_of_week TINYINT NOT NULL , 
day_name VARCHAR(10) NOT NULL ,
day_of_year SMALLINT NOT NULL ,
week_of_year TINYINT NOT NULL , 
month_number TINYINT NOT NULL ,
month_name VARCHAR(10) NOT NULL ,
quarter_no TINYINT NOT NULL ,
quarter_name VARCHAR(2) NOT NULL ,
year_no SMALLINT NOT NULL ,
is_weekend BIT NOT NULL ,
is_leap_year BIT NOT NULL
);
GO

DROP TABLE IF EXISTS Dim_Book;
GO
CREATE TABLE Dim_Book (
book_sk INT IDENTITY(0,1) PRIMARY KEY, 
book_id INT , 
title VARCHAR(400),
isbn13 VARCHAR(13),
num_pages INT ,
publication_date DATE,
publisher_name VARCHAR(400),
language_name VARCHAR(50),
language_code VARCHAR(10)
);

GO

DROP TABLE IF EXISTS Dim_Customer;
GO
CREATE TABLE Dim_Customer (
customer_sk INT IDENTITY(0,1) PRIMARY KEY,
customer_id INT,
first_name VARCHAR(200),
last_name VARCHAR(200),
email VARCHAR(350),
full_name VARCHAR(400),
street_number VARCHAR(10),
street_name VARCHAR(200),
city VARCHAR(100),
country_name VARCHAR(200),
start_date DATE ,
end_date DATE ,
is_current BIT
);
GO


DROP TABLE IF EXISTS Dim_Shipping;
GO

CREATE TABLE Dim_Shipping(
shipping_sk INT IDENTITY(0,1) PRIMARY KEY,
method_id INT ,
method_name VARCHAR(100),
shipping_cost DECIMAL(10,2)
);
GO

DROP TABLE IF EXISTS Dim_OrderStatus;
GO

CREATE TABLE Dim_OrderStatus(
status_sk INT IDENTITY(0,1) PRIMARY KEY,
status_id INT,
status_value VARCHAR(50));

GO

DROP TABLE IF EXISTS Dim_Author;
GO

CREATE TABLE Dim_Author(
author_sk INT IDENTITY(0,1) PRIMARY KEY,
author_id INT , 
author_name VARCHAR(400));

GO

DROP TABLE IF EXISTS Bridge_BookAuthor;

GO


CREATE TABLE Bridge_BookAuthor(
book_sk INT,
author_sk INT,
author_weighting_factor DECIMAL(5,4),
CONSTRAINT pk_bridge_book_author
PRIMARY KEY (book_sk , author_sk)
);

GO 

DROP TABLE IF EXISTS Fact_OdrerLine;

GO 

CREATE TABLE Fact_OrderLine(
orderline_sk INT IDENTITY(1,1) PRIMARY KEY,
date_sk INT NOT NULL ,
book_sk INT NOT NULL , 
customer_sk INT NOT NULL ,
shipping_sk INT NOT NULL , 
status_sk INT NOT NULL, 
order_id INT NOT NULL,
line_id INT NOT NULL,
price DECIMAL(10,2) NULL,
quantity INT  NULL,

 CONSTRAINT fk_fact_date     FOREIGN KEY (date_sk)     
        REFERENCES Dim_Date(date_sk),
    CONSTRAINT fk_fact_book     FOREIGN KEY (book_sk)     
        REFERENCES Dim_Book(book_sk),
    CONSTRAINT fk_fact_customer FOREIGN KEY (customer_sk) 
        REFERENCES Dim_Customer(customer_sk),
    CONSTRAINT fk_fact_shipping FOREIGN KEY (shipping_sk) 
        REFERENCES Dim_Shipping(shipping_sk),
    CONSTRAINT fk_fact_status   FOREIGN KEY (status_sk)   
        REFERENCES Dim_OrderStatus(status_sk)
);
