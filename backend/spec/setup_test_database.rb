require 'pg'

def truncate_rooms_table
  conn = PG.connect(dbname: 'MakersBnB_test')
  conn.exec ('TRUNCATE rooms')
end

def test_vals
  conn = PG.connect(dbname: 'MakersBnB_test')
  conn.exec("INSERT INTO rooms (name, description, price_per_night, available, owner, location) VALUES ('studio flat', 'a studio flat in SE london', 100, true, 'Vu', 'London');")
  
end