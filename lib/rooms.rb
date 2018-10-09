
require 'pg'
require 'json'

class Rooms
  attr_reader :connection, :array_of_rooms

  def self.add_room(name, description, price_per_night, available, owner, location)
    connect_database()
    result = @connection.exec ("INSERT INTO rooms (name, description, price_per_night, available, owner, location) VALUES ('#{name}','#{description}', '#{price_per_night}', '#{available}', '#{owner}', '#{location}');")
  end

  def self.list_rooms 
    connect_database
    array_of_rooms = []
    result = @connection.exec ("SELECT * FROM rooms;")
    result.map do |element|
      array_of_rooms.push(element)
    end
    p array_of_rooms.to_json
    return array_of_rooms.to_json
  end

  def self.book_room(id)
    connect_database()
    @connection.exec ("UPDATE rooms SET available = 'f' WHERE room_id = #{id};")
    p ' Request Room is booked for you.'
  end
  
  private

  def self.connect_database
    if ENV['ENV'] == 'test'
      @connection = PG.connect(dbname: 'MakersBnB_test')
    else
      @connection = PG.connect(dbname: 'MakersBnB')
    end
  end
end