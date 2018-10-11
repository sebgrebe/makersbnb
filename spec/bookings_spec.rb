require 'bookings'

describe Bookings do
  describe '.book_room' do
    before(:each) do
      @offer = {
      'name' => 'studio flat',
      'description' => 'a studio flat in SE london',
      'price' => '100',
      'available' => 't',
      'location' => 'London'
      }
    end
    it 'it allows room to be booked if available' do
      conn = PG.connect(dbname: 'makersbnb_test')
      expect(Bookings.book_room('1')[:booked]).to eq(true)
    end
    it 'it doesn\'t allows room to be booked if not available' do
      conn = PG.connect(dbname: 'makersbnb_test')
      @offer['available'] = 'f'
      Rooms.add_room(@offer, 1)
      id = '3'
      expect(Bookings.book_room(id)[:booked]).to eq(false)
    end
end
end
