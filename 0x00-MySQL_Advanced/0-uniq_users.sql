-- 0-uniq_users.sql
-- SQL script to create a table 'users' with specified attributes

-- Create table 'users' with id, email, and name columns
CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255),
    PRIMARY KEY (id)
);
