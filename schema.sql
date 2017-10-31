-- DEFINE YOUR DATABASE SCHEMA HERE
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS customer_and_account_no;
DROP TABLE IF EXISTS product_name;
DROP TABLE IF EXISTS sale_date;
DROP TABLE IF EXISTS sale_amount;
DROP TABLE IF EXISTS units_sold;
DROP TABLE IF EXISTS invoice_no;
DROP TABLE IF EXISTS invoice_frequency;


CREATE TABLE customer_and_account_no (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE product_name (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE sale_date (
  id SERIAL PRIMARY KEY,
  name timestamp
);

CREATE TABLE sale_amount (
  id SERIAL PRIMARY KEY,
  name integer
);

CREATE TABLE units_sold (
  id SERIAL PRIMARY KEY,
  name integer
);

CREATE TABLE invoice_no (
  id SERIAL PRIMARY KEY,
  name integer
);

CREATE TABLE invoice_frequency (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  customer_and_account_no_id VARCHAR(255),
  product_name_id VARCHAR(255),
  sale_date_id timestamp,
  sale_amount_id integer,
  units_sold_id integer,
  invoice_no_id integer,
  invoice_frequency_id VARCHAR(255)
  );
  
