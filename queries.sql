-- Query 1

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



-- Query 2

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



-- Query 3

SELECT 
    *
FROM 
    Vehicles
WHERE 
    vehicle_type = 'car' 
    AND vehicle_availability_status = 'available';



-- Query 4

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
