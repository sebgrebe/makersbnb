# require 'pg'

# class Bookmarks

  

#   def self.all
#     if ENV['RACK_ENV'] == 'test'
#       @conn = PG.connect( dbname: 'bookmark_manager_test' )
#     else
#       @conn = PG.connect( dbname: 'bookmark_manager' )
#     end
#     retrieve_urls
#   end

#   def self.retrieve_urls
#     @conn.exec( "SELECT url FROM bookmarks") do |result|
#       return formater(result)
#     end
#   end

#   def self.add_url(url)
#     if ENV['RACK_ENV'] == 'test'
#       @conn = PG.connect( dbname: 'bookmark_manager_test' )
#     else
#       @conn = PG.connect( dbname: 'bookmark_manager' )
#     end
#     @conn.exec( "INSERT INTO bookmarks(url) VALUES('#{url}');") 
#   end

#   def self.formater(data)
#     data.map { |line| line['url'] }
#   end

# end

require 'pg'


class Rooms
  attr_reader :connection, :array_of_rooms

  def initialize
    # @array_of_rooms = []
  end

  def self.add_room(name, description, price_per_night, available, owner, location)
    connect_database()
    # if ENV['TEST'] == 'test'
    #   @connection = PG.connect(dbname: 'MakersBnB_test')
    # else
    #   @connection = PG.connect(dbname: 'MakersBnB')
    # end
    result = @connection.exec ("INSERT INTO rooms (name, description, price_per_night, available, owner, location) VALUES ('#{name}','#{description}', '#{price_per_night}', '#{available}', '#{owner}', '#{location}');")
  end

  def self.list_rooms 
    connect_database
    array_of_rooms = []
    # if ENV['TEST'] == 'test'
    #   @connection = PG.connect(dbname: 'MakersBnB_test')
    # else
    #   @connection = PG.connect(dbname: 'MakersBnB')
    # end
    result = @connection.exec ("SELECT * FROM rooms;")
    result.map do |element|
      array_of_rooms.push(element)
    end
    return array_of_rooms
  end

  def self.book_room(id)
    connect_database()
    @connection.exec ("UPDATE rooms SET available = 'f' WHERE room_id = #{id};")
    p ' Request Room is booked for you.'
  end
  
  private

  def self.connect_database
    if ENV['TEST'] == 'test'
      @connection = PG.connect(dbname: 'MakersBnB_test')
    else
      @connection = PG.connect(dbname: 'MakersBnB')
    end
  end
end