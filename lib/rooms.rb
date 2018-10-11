
require 'pg'
require 'json'

class Rooms
  attr_reader :connection, :array_of_rooms

  def self.add_room(offer, user_id)
    connect_database()
    user_id = @connection.exec("SELECT user_id FROM users WHERE user_id=#{user_id}")
    user_id = user_id[0]['user_id']
    result = @connection.exec ("INSERT INTO rooms (room_name, description, price_per_night, available, location, owner_user_id) VALUES ('#{offer['name']}','#{offer['description']}', '#{offer['price']}','#{offer['available']}', '#{offer['location']}', '#{user_id}');")
    return {success: true} if result != nil
    return {success: false, msg: "Sorry, something went wrong"}
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

  def self.users_offers(user_id)
    connect_database
    rooms_without_status = self.users_offers_without_status(user_id)
    rooms = []
    rooms_without_status.map do |room|
      room_id = room['room_id']
      result = @connection.exec("SELECT * FROM bookings WHERE room_id='#{room_id}'")
      if result.ntuples > 0
        result.map do |booking|
          room['booking'] = booking
          room['booking']['booker_name'] = @connection.exec("SELECT first_name FROM users WHERE user_id=#{room['booking']['booker_user_id']}")[0]['first_name']
          rooms.push(room)
        end
      else
        room['booking'] = {}
        room['booking']['status'] = 'Not requested'
        rooms.push(room)
      end
    end
    return {success: true, rooms: rooms}
  end

  def self.users_offers_without_status(user_id)
    connect_database
    result = @connection.exec("SELECT * FROM rooms WHERE owner_user_id = #{user_id}")
    rooms = []
    result.map do |element|
      rooms.push(element)
    end
    return rooms
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
