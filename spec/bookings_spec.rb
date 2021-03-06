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
      expect(Bookings.book_room('1','1')[:success]).to eq(true)
    end
    it 'adds room id and user_id to bookings table' do
      conn = PG.connect(dbname: 'makersbnb_test')
      Bookings.book_room('1','1')
      booking = conn.exec("SELECT * FROM bookings WHERE booking_id ='2'")[0]
      expect(booking['room_id']).to eq '1'
      expect(booking['booker_user_id']).to eq '1'
    end
    it 'it doesn\'t allows room to be booked if not available' do
      conn = PG.connect(dbname: 'makersbnb_test')
      @offer['available'] = 'f'
      Rooms.add_room(@offer, 1)
      id = '3'
      booker_id = '1'
      expect(Bookings.book_room(id,booker_id)[:success]).to eq(false)
    end
  end

  describe '#display_booked_rooms' do
    it "shows a user a list of rooms they've booked" do
      conn = PG.connect(dbname: 'makersbnb_test')
      Bookings.book_room(1, 1)
      Bookings.book_room(2, 1)
      expect(Bookings.display_booked_rooms(1)[0]).to include({"description" => "a studio flat in SE london"})
      expect(Bookings.display_booked_rooms(1)[1]).to include({"description" => "views over East London"})
    end
  end

  describe '#get_booking_status' do
    it "gets a room status" do
      conn = PG.connect(dbname: 'makersbnb_test')
      Bookings.book_room(1, 1)
      expect(Bookings.get_booking_status(1)).to include({"room_id"=>"1", "status"=>"Requested"})
    end
  end

  describe '.confirm' do
    it 'confirms booking' do
      booking_id = '1'
      Bookings.confirm(booking_id)
      conn = PG.connect(dbname: 'makersbnb_test')
      status = conn.exec("SELECT status FROM bookings where booking_id='#{booking_id}'")[0]['status']
      expect(status).to eq ('confirmed')
    end
  end

  describe'.decline' do
    it 'declines the booking' do
      booking_id = '1'
      Bookings.decline(booking_id)
      conn = PG.connect(dbname: 'makersbnb_test')
      status = conn.exec("SELECT status FROM bookings where booking_id='#{booking_id}'")[0]['status']
      expect(status).to eq ('declined')
    end
  end

end
