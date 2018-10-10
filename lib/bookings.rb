
class Bookings

  def self.book_room(id)
    connect_database
    if check_availability(id) == 't'
      @connection.exec ("UPDATE rooms SET available = 'f' WHERE room_id = #{id};")
      result = { :booked => true, :room => map_room_info(id)}
      return result
    else
      result = { :booked => false, :room => map_room_info(id)}
      return result
    end
  end

  private

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

  def self.connect_database
    if ENV['ENV'] == 'test'
      @connection = PG.connect(dbname: 'makersbnb_test')
    else
      @connection = PG.connect(dbname: 'makersbnb')
    end
  end
end
