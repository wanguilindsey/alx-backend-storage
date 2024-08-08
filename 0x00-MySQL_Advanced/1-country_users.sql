-- 1-country_users.sql
-- SQL script to create a table 'users' with id, email, name, and country attributes

-- Create table 'users' with id, email, name, and country columns
CREATE TABLE IF NOT EXISTS users (
    id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255),
    country ENUM('US', 'CO', 'TN') NOT NULL DEFAULT 'US',
    PRIMARY KEY (id)
);
