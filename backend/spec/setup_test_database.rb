require 'pg'

def truncate_rooms_table
  conn = PG.connect(dbname: 'MakersBnB_test')
  conn.exec ('TRUNCATE rooms')
end

def drop_rooms_table
  conn = PG.connect(dbname: 'MakersBnB_test')
  conn.exec ('DROP TABLE rooms;')
end

def test_vals
  conn = PG.connect(dbname: 'MakersBnB_test')
  conn.exec("CREATE TABLE rooms (room_id SERIAL PRIMARY KEY, name VARCHAR(20),description VARCHAR(200), price_per_night INTEGER, available BOOLEAN, owner VARCHAR(20), location VARCHAR(50));")
  conn.exec("INSERT INTO rooms (name, description, price_per_night, available, owner, location) VALUES ('studio flat', 'a studio flat in SE london', 100, true, 'Vu', 'London');")
  
end