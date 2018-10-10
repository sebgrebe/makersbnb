require 'pg'

def setup_test_database
  conn = PG.connect(dbname: 'makersbnb_test')
  conn.exec ('DROP TABLE IF EXISTS users CASCADE;')
  conn.exec ('DROP TABLE IF EXISTS rooms CASCADE;')
  conn.exec ('DROP TABLE IF EXISTS bookings;')

  conn.exec("CREATE TABLE users ( user_id SERIAL PRIMARY KEY, email VARCHAR(355) UNIQUE NOT NULL, password VARCHAR(240) NOT NULL, first_name VARCHAR(20) NOT NULL, last_name VARCHAR(20) NOT NULL);")
  conn.exec("CREATE TABLE rooms ( room_id SERIAL PRIMARY KEY, room_name VARCHAR(20), description VARCHAR (200), price_per_night INTEGER, available BOOLEAN, location VARCHAR(50), owner_user_id INTEGER REFERENCES users(user_id) );")
  conn.exec("CREATE TABLE bookings ( booking_id SERIAL PRIMARY KEY, room_id INTEGER REFERENCES rooms(room_id), booker_user_id INTEGER REFERENCES users(user_id), status VARCHAR (20) );")

  conn.exec("INSERT INTO rooms (room_name, description, price_per_night, available, location) VALUES ('studio flat', 'a studio flat in SE london', 100, true, 'London');")
  conn.exec("INSERT INTO rooms (room_name, description, price_per_night, available, location) VALUES ('penthouse', 'views over East London', 500, true, 'East London');")
end
