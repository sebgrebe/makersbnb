require 'pg'

class Bookings

  def self.book_room(room_id, booker_id)
    connect_database
    if check_availability(room_id) == 't'
      result = self.change_availability('f', room_id)
      self.add_booking(room_id, booker_id)
      return result
    else
      result = { :success => false, :room => map_room_info(room_id)}
      return result
    end
  end


  private

  def self.add_booking(room_id, booker_id)
    booker_id = @connection.exec("SELECT user_id FROM users WHERE user_id=#{booker_id}")
    booker_id = booker_id[0]['user_id']
    room_id = @connection.exec("SELECT room_id FROM rooms WHERE room_id=#{room_id}")
    room_id = room_id[0]['room_id']
    @connection.exec ("INSERT INTO bookings (room_id, booker_user_id, status) VALUES('#{room_id}', '#{booker_id}','Requested');")
  end

  def self.change_availability(bool_str, room_id)
    @connection.exec ("UPDATE rooms SET available = '#{bool_str}' WHERE room_id = #{room_id};")
    return { :success => true, :room => map_room_info(room_id)}
  end

  def self.map_room_info(room_id)
    array_of_rooms = []
    result = @connection.exec ("SELECT * FROM rooms WHERE room_id = #{room_id};")
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

  def self.confirm(booking_id)
    connect_database
    @connection.exec("UPDATE bookings SET status = 'confirmed' where booking_id='#{booking_id}' returning status")[0]['status']
  end

  def self.decline(booking_id)
    connect_database
    @connection.exec("UPDATE bookings SET status = 'declined' where booking_id='#{booking_id}' returning status")[0]['status']
  end

  def self.connect_database
    if ENV['ENV'] == 'test'
      @connection = PG.connect(dbname: 'makersbnb_test')
    else
      @connection = PG.connect(dbname: 'makersbnb')
    end
  end
end
