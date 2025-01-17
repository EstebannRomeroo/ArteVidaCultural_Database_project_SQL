/* -----------------------------------------------------------------------------------------------
Author: Esteban Camilo Romero Lozano
Database: ArteVidaCultural
---------------------------------------------------------------------------------------------------*/
-- Create the database ArteVidaCultural
DROP DATABASE IF exists ArteVidaCultural;
CREATE DATABASE ArteVidaCultural;
USE ArteVidaCultural;

/* ------------------------------------------------------------------------------------------------
Definition of the database structure
--------------------------------------------------------------------------------------------------*/
-- Create table activities
CREATE TABLE activities(
	id_activity INT PRIMARY KEY AUTO_INCREMENT,
    name_activity VARCHAR(100) NOT NULL,
    type_activity VARCHAR(50) NOT NULL,
    total_cost DECIMAL(10,2)
);

-- Create table artists
CREATE TABLE artists(
	id_artist INT PRIMARY KEY AUTO_INCREMENT,
    name_artist VARCHAR(100) NOT NULL,
    cache DECIMAL(10,2) NOT NULL,
    biography TEXT
);

-- Create table locations
CREATE TABLE locations(
	id_location INT PRIMARY KEY AUTO_INCREMENT,
    name_location VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    city VARCHAR(100) NOT NULL,
    capacity INT NOT NULL,
    rental_price DECIMAL(10,2) NOT NULL,
    features TEXT
);

-- Create table events
CREATE TABLE events(
	id_event INT PRIMARY KEY AUTO_INCREMENT,
    name_event VARCHAR(150) NOT NULL,
    id_activity INT,
    id_location INT,
    ticket_price DECIMAL(10,2) NOT NULL,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    description TEXT,
    FOREIGN KEY (id_activity) REFERENCES activities(id_activity),
    FOREIGN KEY (id_location) REFERENCES locations(id_location)
);

-- Create table attendees
CREATE TABLE attendees(
	id_attendee INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(150) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Create table participations
CREATE TABLE participations(
	id_participation INT PRIMARY KEY AUTO_INCREMENT,
    id_artist INT,
    id_activity INT,
    FOREIGN KEY (id_artist) REFERENCES artists(id_artist),
    FOREIGN KEY (id_activity) REFERENCES activities(id_activity)
);

-- Create table attendances
CREATE TABLE attendances(
	id_attendance INT PRIMARY KEY AUTO_INCREMENT,
    id_attendee INT,
    id_event INT,
    FOREIGN KEY (id_attendee) REFERENCES attendees(id_attendee),
    FOREIGN KEY (id_event) REFERENCES events(id_event)
);