
require 'pg'
require 'json'

class Rooms
  attr_reader :connection, :array_of_rooms

  def self.add_room(offer)
    connect_database()
    result = @connection.exec ("INSERT INTO rooms (name, description, price_per_night, available, owner, location) VALUES ('#{offer['name']}','#{offer['description']}', '#{offer['price']}', '#{offer['available']}', '#{offer['owner_user_id']}', '#{offer['location']}');")
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

  def self.check_availability(id)
    connect_database
    available = @connection.exec("SELECT available FROM rooms WHERE room_id = #{id};")
    available.each do |x|
      return x['available']
    end
  end
  def self.book_room(id)
    connect_database
    if check_availability(id) == 't'
      @connection.exec ("UPDATE rooms SET available = 'f' WHERE room_id = #{id};")
      result = { :booked => true, :room => (@connection.exec ("SELECT * FROM rooms WHERE room_id = #{id};"))}
      return result
    else
      result = { :booked => false, :room => (@connection.exec ("SELECT * FROM rooms WHERE room_id = #{id};"))}
      return result
    end
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
