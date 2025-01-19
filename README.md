# ArteVidaCultural Database Project

## 📖 Overview
**ArteVidaCultural** is a relational database project designed to manage cultural events. It provides efficient management of activities, artists, locations, attendees, and event participation. This project showcases a complete database structure, data population, triggers, views, and queries for analysis and reporting.

---

## ⚙️ Technologies Used
- **Database**: MySQL
- **Language**: SQL
- **Tools**: MySQL Workbench

---

## 📂 Project Structure
The project is divided into the following parts:

1. **Database Schema**:
   - Tables: `activities`, `artists`, `locations`, `events`, `attendees`, `participations`, `attendances`, and `attendance_log`.
   - Relationships between tables ensure data integrity.

2. **Sample Data**:
   - Fictional data is inserted to populate the tables for testing and demonstration purposes.

3. **Queries**:
   - A set of example queries is provided to retrieve and analyze data.

4. **Triggers**:
   - A trigger logs attendance insertions in the `attendance_log` table automatically.

5. **Views**:
   - Views simplify complex queries, providing insights into events, attendees, revenue, and artists.

---

## 🗂️ File Organization
The project is organized into multiple SQL files for clarity and modularity:

1. **`01_create_tables.sql`**: Contains the database creation and table definitions.
2. **`02_insert_data.sql`**: Populates the tables with fictional data for testing.
3. **`03_queries.sql`**: Includes sample queries to retrieve meaningful insights.
4. **`04_views.sql`**: Defines the views for simplifying complex queries.
5. **`05_triggers.sql`**: Implements a trigger to log attendance events in a separate log table.

---

## 🛠️ How to Use
Follow these steps to set up and run the project:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/YourUsername/ArteVidaCultural.git
   cd ArteVidaCultural
   ```

2. **Run the scripts in sequence**:
   - Create the database and tables:
     ```bash
     mysql -u username -p < 01_create_tables.sql
     ```
   - Insert the sample data:
     ```bash
     mysql -u username -p < 02_insert_data.sql
     ```
   - Test the queries:
     ```bash
     mysql -u username -p < 03_queries.sql
     ```
   - Create views:
     ```bash
     mysql -u username -p < 04_views.sql
     ```
   - Set up triggers:
     ```bash
     mysql -u username -p < 05_triggers.sql
     ```

3. **Explore the views**:
   Use the views to quickly access summarized data:
   ```sql
   SELECT * FROM view_event_details;
   SELECT * FROM view_attendees_events;
   SELECT * FROM view_event_revenue;
   SELECT * FROM view_event_artists;
   ```

---

## 📝 Features
### **1. Tables**
- **Activities**: Stores details of activities like workshops and performances.
- **Artists**: Contains information about artists and their cache.
- **Locations**: Details of event venues, including capacity and rental price.
- **Events**: Links activities and locations with event-specific details.
- **Attendees**: Information about attendees, including unique emails.
- **Participations**: Links artists to activities.
- **Attendances**: Links attendees to events.
- **Attendance Log**: Automatically logs new attendance entries via a trigger.

### **2. Views**
- **Event Details**: Combines event, location, and activity details.
- **Attendees Events**: Links attendees to the events they registered for.
- **Event Revenue**: Calculates total revenue per event.
- **Event Artists**: Displays artists associated with each event.

### **3. Trigger**
- Automatically logs attendance entries in a separate log table.

---

## 📋 Example Queries
Here are some queries included in the project:

1. **List all events with their location and city**:
   ```sql
   SELECT e.name_event, l.name_location, l.city
   FROM events e
   JOIN locations l ON e.id_location = l.id_location;
   ```

2. **Count the number of attendees per event**:
   ```sql
   SELECT e.name_event, COUNT(a.id_attendance) AS Total_Attendees
   FROM events e
   JOIN attendances a ON e.id_event = a.id_event
   GROUP BY e.name_event;
   ```

3. **Calculate revenue per event**:
   ```sql
   SELECT e.name_event, e.ticket_price * COUNT(a.id_attendance) AS Revenue
   FROM events e
   JOIN attendances a ON e.id_event = a.id_event
   GROUP BY e.id_event;
   ```

---

## 📧 Contact
For any questions or feedback, please contact:
- **Email**: estebanromero124@gmail.com
- **GitHub**: [EstebannRomeroo](https://github.com/EstebannRomeroo)

---

If you find this project helpful, feel free to star the repository! 🌟

---
