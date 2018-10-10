require 'pg'
require 'rooms'
require 'json'


describe Rooms do
  describe '.add_room' do
    before(:each) do
      @offer = {
      'name' => 'studio flat',
      'description' => 'a studio flat in SE london',
      'price' => '100',
      'available' => 't',
      'location' => 'London'
      }
    end
    it 'it add a room to the rooms table' do
      Rooms.add_room(@offer)
      conn = PG.connect(dbname: 'makersbnb_test')
      results = conn.exec("SELECT * FROM rooms;")[2]
      expect(results['room_name']).to eq(@offer['name'])
      expect(results['description']).to eq(@offer['description'])
      expect(results['price_per_night']).to eq(@offer['price'])
      expect(results['available']).to eq(@offer['available'])
      expect(results['location']).to eq(@offer['location'])
    end
    it 'returns "success" on success' do
      expect(Rooms.add_room(@offer)).to eq "success"
    end
  end

  describe '.list_rooms' do
    it 'it can list all the rooms from rooms table' do
      result = Rooms.list_rooms[0]
      expect(result).to eq({'room_id' => '1',
        'room_name' => 'studio flat',
        'description' => 'a studio flat in SE london',
        'price_per_night' => '100',
        'available' => 't',
        'location' => 'London',
        'owner_user_id' => nil})
    end
  end

end
