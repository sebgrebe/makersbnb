require 'pg'
require 'rooms'
require 'json'


describe Rooms do
  describe '.add_room' do
    before(:each) do
      @name = 'studio flat'
      @description = 'a studio flat in SE london'
      @price_per_night = '100'
      @available = 't'
      @owner = 'Vu'
      @location = 'London'
    end
    it 'it add a room to the rooms table' do
      Rooms.add_room(@name, @description, @price_per_night, @available, @owner, @location)
      conn = PG.connect(dbname: 'makersbnb_test')
      results = conn.exec("SELECT * FROM rooms;")
      expect(results[0]['name']).to eq(@name)
      expect(results[0]['description']).to eq(@description)
      expect(results[0]['price_per_night']).to eq(@price_per_night)
      expect(results[0]['available']).to eq(@available)
      expect(results[0]['owner']).to eq(@owner)
      expect(results[0]['location']).to eq(@location)
    end
  end

  describe '.list_rooms' do
    it 'it can list all the rooms from rooms table' do
      result = Rooms.list_rooms[0]
      expect(result).to eq({'room_id' => '1',
        'name' => 'studio flat',
        'description' => 'a studio flat in SE london',
        'price_per_night' => '100',
        'available' => 't',
        'owner' => 'Vu',
        'location' => 'London'})
    end
  end

  describe '.book_room' do
    before(:each) do
      @name = 'studio flat'
      @description = 'a studio flat in SE london'
      @price_per_night = '100'
      @available = 't'
      @owner = 'Vu'
      @location = 'London'
    end
    it 'it allows room to be booked if available' do
      conn = PG.connect(dbname: 'makersbnb_test')
      Rooms.add_room(@name, @description, @price_per_night, @available, @owner, @location)
      id = '1'
      expect(Rooms.book_room(id)[:booked]).to eq(true)
    end
  it 'it doesn\'t allows room to be booked if available' do
    conn = PG.connect(dbname: 'makersbnb_test')
    Rooms.add_room(@name, @description, @price_per_night, 'f', @owner, @location)
    id = '3'
    expect(Rooms.book_room(id)[:booked]).to eq(false)
  end
end
end
