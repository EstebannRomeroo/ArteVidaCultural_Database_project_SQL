/* -----------------------------------------------------------------------------------------------
Author: Esteban Camilo Romero Lozano
Database: ArteVidaCultural
---------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------
Queries
---------------------------------------------------------------------------------------------------*/
-- 1. List all events with their location name and city.
-- This query retrieves the name of the events, their corresponding locations, and the city where each event takes place.

SELECT e.name_event  AS Event_name,
l.name_location as Location, l.city as City
FROM events e
INNER JOIN locations l ON l.id_location = e.id_location;

-- 2. Show the type of activity for each event.
-- This query displays the name of the events and the type of activity associated with each one.

SELECT e.name_event  AS Event_name,
a.type_activity as 'Type Activity'
FROM events e
JOIN activities a ON a.id_activity = e.id_activity;

-- 3. Count the number of attendees for each event.
-- This query calculates the total number of attendees registered for each event.

SELECT e.name_event,
COUNT(a.id_attendance) as '# Attendances'
FROM events e
JOIN attendances a on a.id_event = e.id_event
GROUP BY e.name_event;

-- 4. List the names of artists participating in each event.
-- This query retrieves the names of the events and the artists associated with each one.

SELECT e.name_event as Event_Name, 
a.name_artist as Artist_Name
FROM events e
JOIN participations p on p.id_activity = e.id_activity
JOIN artists a on a.id_artist = p.id_artist;

-- 5. Calculate the total revenue for each event based on ticket price and the number of attendees.
-- This query multiplies the ticket price by the number of attendees to calculate the total revenue for each event.

SELECT e.name_event as Event_Name,
(e.ticket_price * COUNT(a.id_attendance)) as 'Revenue'
FROM events e
JOIN attendances a on a.id_event = e.id_event
group by e.id_event;

-- 6. Show the attendees and the events they attended.
-- This query lists the names of attendees along with the events they registered for.

SELECT e.name_event as Event_Name,
at.full_name as Name
FROM events e
JOIN attendances a on a.id_event = e.id_event
JOIN attendees at on at.id_attendee = a.id_attendee;

-- 7. Events with more than 5 attendees.
-- This query identifies events that have more than 5 attendees registered.

SELECT e.name_event as Event_Name,
COUNT(a.id_attendance) as 'Attendee_Count'
FROM events e
JOIN attendances a on a.id_event = e.id_event
GROUP BY e.id_event
HAVING COUNT(a.id_attendance) > 5;

-- 8. Show artists and their total cost by activity.
-- This query calculates the total cost (cache) of all artists participating in each activity.

SELECT art.name_artist, sum(art.cache) as Total_Cost
FROM activities a
JOIN participations p on p.id_activity = a.id_activity
JOIN artists art on art.id_artist = p.id_artist
GROUP BY art.name_artist
ORDER BY total_cost desc;

-- 9. Find the most attended events, ordered by the number of attendees.
-- This query lists the events ordered by the number of attendees in descending order, showing the most popular events first.

SELECT e.name_event as Event_Name,
COUNT(a.id_attendance) as 'Attendee_Count'
FROM events e
JOIN attendances a on a.id_event = e.id_event
GROUP BY e.id_event
ORDER BY Attendee_Count desc;

-- 10. List events taking place in a specific city.
-- This query retrieves the names of events along with their locations and cities, filtered by a specific city.

SELECT e.name_event  AS Event_name,
l.name_location as Location, l.city as City
FROM events e
JOIN locations l ON l.id_location = e.id_location
WHERE l.city in ('Chicago', 'Los Angeles', 'Nashville');