require 'bookings'

describe Bookings do
  describe '.book_room' do
    before(:each) do
      @name = 'studio flat'
      @description = 'a studio flat in SE london'
      @price_per_night = '100'
      @available = 't'
      @location = 'London'
    end
    it 'it allows room to be booked if available' do
      conn = PG.connect(dbname: 'makersbnb_test')
      Rooms.add_room(@name, @description, @price_per_night, @available, @location)
      id = '1'
      expect(Bookings.book_room(id)[:booked]).to eq(true)
    end
  it 'it doesn\'t allows room to be booked if not available' do
    conn = PG.connect(dbname: 'makersbnb_test')
    Rooms.add_room(@name, @description, @price_per_night, 'f', @location)
    id = '3'
    expect(Bookings.book_room(id)[:booked]).to eq(false)
  end
end
end
