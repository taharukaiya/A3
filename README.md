# Vehicle Rental System - Database Design & SQL Queries

## 📋 Project Overview

This project implements a comprehensive database design for a Vehicle Rental System. The system manages users, vehicles, and bookings through a well-structured relational database that supports real-world rental operations.

The database is designed to handle:

- User management (Admins and Customers)
- Vehicle inventory tracking
- Booking and reservation management
- Rental status monitoring

---

## 🗂️ Database Design

### ERD (Entity Relationship Diagram)

**ERD Link:** [Vehicle Rental System ERD](https://drawsql.app/teams/none-4561/diagrams/vehicle-rental-system)

### Database Schema

The database consists of three main tables:

#### 1. **Users Table**

Stores information about system users (both customers and administrators).

**Fields:**

- `user_id` (Primary Key) - Unique identifier for each user
- `user_role` - User role (Admin or Customer)
- `user_name` - User's full name
- `user_email` - User's email address (unique constraint)
- `user_phone_number` - Contact phone number
- `user_password` - User's password

#### 2. **Vehicles Table**

Maintains the inventory of all rental vehicles.

**Fields:**

- `vehicle_id` (Primary Key) - Unique identifier for each vehicle
- `vehicle_name` - Vehicle name/model name
- `vehicle_type` - Vehicle category (car/bike/truck)
- `vehicle_model` - Vehicle model year
- `vehicle_registration_number` - License plate number (unique constraint)
- `vehicle_per_day_rent_price` - Daily rental cost
- `vehicle_availability_status` - Current availability (available/rented/maintenance)

#### 3. **Bookings Table**

Records all rental bookings and their details.

**Fields:**

- `booking_id` (Primary Key) - Unique identifier for each booking
- `user_id` (Foreign Key) - References Users table
- `vehicle_id` (Foreign Key) - References Vehicles table
- `booking_rental_start_date` - Rental start date
- `booking_rental_end_date` - Rental end date
- `booking_status` - Booking status (pending/confirmed/completed/cancelled)
- `booking_cost` - Total rental cost

### Relationships

The database implements the following relationships:

- **One to Many**: User → Bookings
  - One user can make multiple bookings
- **Many to One**: Bookings → Vehicle
  - Multiple bookings can be associated with one vehicle
- **One to One (Logical)**: Each booking connects exactly one user to one vehicle at a specific time

---

## 🔍 SQL Queries

This project includes four key SQL queries demonstrating different database operations:

### Query 1: JOIN Operation

Retrieves comprehensive booking information by joining bookings with customer and vehicle details.

**Concepts Used:** INNER JOIN

**Output:** Displays booking_id, customer_name, vehicle_name, booking_rental_start_date, booking_rental_end_date, and booking_status

**SQL Query:**

```sql
SELECT
    b.booking_id,
    u.user_name AS customer_name,
    v.vehicle_name AS vehicle_name,
    b.booking_rental_start_date,
    b.booking_rental_end_date,
    b.booking_status
FROM
    Bookings AS b
INNER JOIN
    Users AS u ON b.user_id = u.user_id
INNER JOIN
    Vehicles AS v ON b.vehicle_id = v.vehicle_id;
```

**Explanation:**
This query demonstrates the use of INNER JOIN to combine data from three tables:

- Uses aliases (b, u, v) for cleaner code
- Joins Bookings with Users table on user_id to get customer information
- Joins Bookings with Vehicles table on vehicle_id to get vehicle details
- Returns a comprehensive view of all bookings with customer names and vehicle information

---

### Query 2: EXISTS Clause

Identifies vehicles that have never been booked, useful for inventory analysis.

**Concepts Used:** NOT EXISTS

**Output:** Lists all vehicles with no booking history

**SQL Query:**

```sql
SELECT
    *
FROM
    Vehicles AS v
WHERE
    NOT EXISTS (
        SELECT 1
        FROM Bookings AS b
        WHERE b.vehicle_id = v.vehicle_id
    );
```

**Explanation:**
This query uses the NOT EXISTS clause to find unused inventory:

- Selects all columns from the Vehicles table
- The subquery checks if any bookings exist for each vehicle
- NOT EXISTS returns true only when no matching bookings are found
- Useful for identifying vehicles that may need marketing or pricing adjustments

---

### Query 3: WHERE Clause

Filters and retrieves available vehicles of a specific type (e.g., cars).

**Concepts Used:** SELECT, WHERE

**Output:** Shows available vehicles where vehicle_type is 'car' and vehicle_availability_status is 'available'

**SQL Query:**

```sql
SELECT
    *
FROM
    Vehicles
WHERE
    vehicle_type = 'car'
    AND vehicle_availability_status = 'available';
```

**Explanation:**
This query demonstrates basic filtering with WHERE clause:

- Retrieves all columns from Vehicles table
- Applies two conditions using AND operator
- Filters for vehicles of type 'car'
- Only shows vehicles with 'available' status
- Practical for customer-facing vehicle search functionality

---

### Query 4: Aggregation with Filtering

Analyzes booking patterns by finding vehicles with high demand (more than 2 bookings).

**Concepts Used:** GROUP BY, HAVING, COUNT

**Output:** Displays vehicle_name and total_bookings for vehicles with more than 2 bookings

**SQL Query:**

```sql
SELECT
    v.vehicle_name AS vehicle_name,
    COUNT(b.booking_id) AS total_bookings
FROM
    Vehicles AS v
INNER JOIN
    Bookings AS b ON v.vehicle_id = b.vehicle_id
GROUP BY
    v.vehicle_id, v.vehicle_name
HAVING
    COUNT(b.booking_id) > 2;
```

**Explanation:**
This query demonstrates aggregation functions and filtering on aggregated data:

- Joins Vehicles and Bookings tables to count bookings per vehicle
- GROUP BY groups results by vehicle (using both vehicle_id and vehicle_name)
- COUNT() aggregate function counts the number of bookings for each vehicle
- HAVING clause filters groups after aggregation (unlike WHERE which filters before)
- Returns only vehicles with more than 2 bookings
- Useful for identifying popular vehicles and demand patterns

---
