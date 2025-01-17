/* -----------------------------------------------------------------------------------------------
Author: Esteban Camilo Romero Lozano
Database: ArteVidaCultural
---------------------------------------------------------------------------------------------------*/
/*------------------------------------------------------------------------------------------------------
Trigger: Automatically log attendance insertions
-------------------------------------------------------------------------------------------------------*/

-- Create table attendance_log

CREATE TABLE attendance_log (
	id_log INT PRIMARY KEY AUTO_INCREMENT,
    id_attendee INT,
    id_event INT,
    log_message TEXT,
    log_date DATETIME
);

-- Create trigger for logs

DELIMITER $$

CREATE TRIGGER after_attendance_insert
AFTER INSERT ON attendances
FOR EACH ROW
BEGIN
    -- Check if the log entry already exists
    IF NOT EXISTS (
        SELECT 1
        FROM attendance_log
        WHERE id_attendee = NEW.id_attendee
          AND id_event = NEW.id_event
    ) THEN
        -- Insert a log entry if it doesn't exist
        INSERT INTO attendance_log (id_attendee, id_event, log_message, log_date)
        VALUES (
            NEW.id_attendee,
            NEW.id_event,
            CONCAT('Attendee ID ', NEW.id_attendee, ' registered for Event ID ', NEW.id_event),
            NOW()
        );
    END IF;
END;
-- The 'attendance_log' table is updated whenever a new attendance is added to the 'attendances' table.
$$
DELIMITER ;

-- Insert values into the table attendances

INSERT INTO attendances (id_attendee, id_event)
VALUES
(1, 10),
(3, 29),
(25, 23),
(25, 7);

SELECT * FROM attendance_log;

/*------------------------------------------------------------------------------------------------------
Create Views:
These views simplify complex queries by combining data from multiple tables into a readable format.
-------------------------------------------------------------------------------------------------------*/

-- Create a view for events details

CREATE VIEW view_event_details AS
SELECT e.name_event AS Event_Name,
l.name_location AS Location,
l.city AS City,
a.type_activity AS Activity_Type,
e.event_date AS Event_Date,
e.event_time AS Event_Time
FROM events e
JOIN locations l ON e.id_location = l.id_location
JOIN activities a ON e.id_activity = a.id_activity;

-- Create a view for attendees events

CREATE VIEW view_attendees_events AS
SELECT at.full_name AS Attendee_Name,
e.name_event AS Event_Name,
e.event_date AS Event_Date,
e.event_time AS Event_Time
FROM attendances a
JOIN attendees at ON a.id_attendee = at.id_attendee
JOIN events e ON a.id_event = e.id_event;

-- Create view event revenue

CREATE VIEW view_event_revenue AS
SELECT 
e.name_event AS Event_Name,
e.ticket_price AS Ticket_Price,
COUNT(a.id_attendance) AS Number_of_Attendees,
(e.ticket_price * COUNT(a.id_attendance)) AS Total_Revenue
FROM events e
LEFT JOIN attendances a ON e.id_event = a.id_event
GROUP BY e.id_event
ORDER BY Total_Revenue desc;

-- Create view event artists

CREATE VIEW view_event_artists AS
SELECT e.name_event AS Event_Name,
ar.name_artist AS Artist_Name,
ar.cache AS Artist_Cache
FROM events e
JOIN activities act ON e.id_activity = act.id_activity
JOIN participations p ON act.id_activity = p.id_activity
JOIN artists ar ON p.id_artist = ar.id_artist;

-- View: Event Details
-- This query retrieves detailed information about events, including their name, location, city, type of activity, date, and time.
SELECT * FROM view_event_details;

-- View: Attendees and Events
-- This query lists the attendees and the events they have registered for, including the event's date and time.
SELECT * FROM view_attendees_events;

-- View: Event Revenue
-- This query calculates the total revenue for each event, including the ticket price, number of attendees, and total earnings.
SELECT * FROM view_event_revenue;

-- View: Event Artists
-- This query displays the artists participating in each event, along with their names and cache amounts.
SELECT * FROM view_event_artists;
