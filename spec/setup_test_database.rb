require 'pg'

def setup_test_database
  conn = PG.connect(dbname: 'makersbnb_test')
  conn.exec ('DROP TABLE IF EXISTS rooms;')

  conn.exec("CREATE TABLE rooms (room_id SERIAL PRIMARY KEY, name VARCHAR(20),description VARCHAR(200), price_per_night INTEGER, available BOOLEAN, owner VARCHAR(20), location VARCHAR(50));")
  conn.exec("INSERT INTO rooms (name, description, price_per_night, available, owner, location) VALUES ('studio flat', 'a studio flat in SE london', 100, true, 'Vu', 'London');")
  conn.exec("INSERT INTO rooms (name, description, price_per_night, available, owner, location) VALUES ('penthouse', 'views over East London', 500, true, 'Nazia', 'East London');")
end
