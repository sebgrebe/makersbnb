
require 'pg'
require 'json'

class Rooms
  attr_reader :connection, :array_of_rooms


  def self.add_room(offer)
    connect_database()
    result = @connection.exec ("INSERT INTO rooms (room_name, description, price_per_night, available, location) VALUES ('#{offer['name']}','#{offer['description']}', '#{offer['price']}','#{offer['available']}', '#{offer['location']}');")
    return "success" if result != nil
    return "failure"
  end

  def self.list_rooms
    connect_database
    array_of_rooms = []
    result = @connection.exec ("SELECT * FROM rooms;")
    result.map do |element|
      array_of_rooms.push(element)
    end
    return array_of_rooms
  end

  def self.get_room(id)
    connect_database
    room = @connection.exec("SELECT * FROM rooms WHERE room_id = #{id};")
    return room[0]
  end


  private

  def self.connect_database
    if ENV['ENV'] == 'test'
      @connection = PG.connect(dbname: 'makersbnb_test')
    else
      @connection = PG.connect(dbname: 'makersbnb')
    end
  end
end
