-- Create Users Table: includes a JSONB column for flexible user preferences
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    budget VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    preferences JSONB,  -- e.g., {"language": "en", "currency": "USD", "seat_preference": "aisle"}
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create Trips Table: holds trip details; 'created_by' references the user who started the trip
CREATE TABLE trips (
    trip_id SERIAL PRIMARY KEY,
    trip_name VARCHAR(255) NOT NULL,
    cost VARCHAR(255) NOT NULL,
    description TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    destination VARCHAR(255) NOT NULL,
    created_by INTEGER REFERENCES users(user_id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create Flights Table: each flight is linked to a trip, ensuring that deleting a trip removes its flights
CREATE TABLE flights (
    flight_id SERIAL PRIMARY KEY,
    trip_id INTEGER REFERENCES trips(trip_id) ON DELETE CASCADE,
    airline VARCHAR(100) NOT NULL,
    flight_number VARCHAR(50),
    departure_airport VARCHAR(50) NOT NULL,
    arrival_airport VARCHAR(50) NOT NULL,
    departure_time TIMESTAMPTZ NOT NULL,
    arrival_time TIMESTAMPTZ NOT NULL,
    price DECIMAL(10,2),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create Activities Table: each activity is tied to a trip
CREATE TABLE activities (
    activity_id SERIAL PRIMARY KEY,
    trip_id INTEGER REFERENCES trips(trip_id) ON DELETE CASCADE,
    activity_name VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    activity_date TIMESTAMPTZ NOT NULL,
    description TEXT,
    price DECIMAL(10,2),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

