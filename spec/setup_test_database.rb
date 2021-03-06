require 'pg'

def setup_test_database
  conn = PG.connect(dbname: 'makersbnb_test')
  conn.exec ('DROP TABLE IF EXISTS users CASCADE;')
  conn.exec ('DROP TABLE IF EXISTS rooms CASCADE;')
  conn.exec ('DROP TABLE IF EXISTS bookings;')

  conn.exec("CREATE TABLE users ( user_id SERIAL PRIMARY KEY, email VARCHAR(355) UNIQUE NOT NULL, password VARCHAR(240) NOT NULL, first_name VARCHAR(20) NOT NULL, last_name VARCHAR(20) NOT NULL);")
  conn.exec("CREATE TABLE rooms ( room_id SERIAL PRIMARY KEY, room_name VARCHAR(20), description VARCHAR (200), price_per_night INTEGER, available BOOLEAN, location VARCHAR(50), owner_user_id INTEGER REFERENCES users(user_id) );")
  conn.exec("CREATE TABLE bookings ( booking_id SERIAL PRIMARY KEY, room_id INTEGER REFERENCES rooms(room_id), booker_user_id INTEGER REFERENCES users(user_id), status VARCHAR (20) );")
  
  #adding two users (test and test2) to users table
  conn.exec("INSERT INTO users (email, password, first_name, last_name) VALUES ('test@example.com', 'test', 'test_name', 'test_name');")
  conn.exec("INSERT INTO users (email, password, first_name, last_name) VALUES ('test2@example.com', 'test2', 'test_name2', 'test_name2');")
  
  user1_id = conn.exec("SELECT user_id FROM users WHERE user_id='1';")[0]['user_id']
  user2_id = conn.exec("SELECT user_id FROM users WHERE user_id='2';")[0]['user_id']
  p "user2_id", user2_id

  #adding two rooms, both owned by user test
  conn.exec("INSERT INTO rooms (room_name, description, price_per_night, available, location, owner_user_id) VALUES ('studio flat', 'a studio flat in SE london', 100, true, 'London', '#{user1_id}');")
  conn.exec("INSERT INTO rooms (room_name, description, price_per_night, available, location, owner_user_id) VALUES ('penthouse', 'views over East London', 500, true, 'East London', '#{user1_id}');")
  room1_id = conn.exec("SELECT room_id FROM rooms WHERE room_id='1';")[0]['room_id']
  
  #adding booking, test2 booking room1 from test
  conn.exec ("INSERT INTO bookings (room_id, booker_user_id, status) VALUES('#{room1_id}', '#{user2_id}','Requested');")


  # conn.exec("INSERT INTO users (email, password, first_name, last_name) VALUES ('test@example.com', 'test', 'test_name', 'test_name');")
end
