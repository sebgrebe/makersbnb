
require 'pg'
require 'json'

class Rooms
  attr_reader :connection, :array_of_rooms

  def self.add_room(name, description, price_per_night, available, location)
    connect_database()
    result = @connection.exec ("INSERT INTO rooms (room_name, description, price_per_night, available, location) VALUES ('#{name}','#{description}', '#{price_per_night}', '#{available}', '#{location}');")
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

  private

  def self.connect_database
    if ENV['ENV'] == 'test'
      @connection = PG.connect(dbname: 'makersbnb_test')
    else
      @connection = PG.connect(dbname: 'makersbnb')
    end
  end
end
