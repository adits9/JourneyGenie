Retrieve a User’s Preferences:
SELECT user_id, first_name, last_name, preferences
FROM users
WHERE email = 'user@example.com';

Retrieve Flight Options for a Specific Trip:
SELECT flight_id, airline, flight_number, departure_airport, arrival_airport, departure_time, arrival_time, price
FROM flights
WHERE trip_id = 1
ORDER BY departure_time;

Find Flights Between Specific Airports on a Certain Date:
SELECT flight_id, airline, flight_number, departure_airport, arrival_airport, departure_time, arrival_time, price
FROM flights
WHERE departure_airport = 'JFK'
  AND arrival_airport = 'LHR'
  AND departure_time::date = '2025-04-15'
ORDER BY departure_time;

