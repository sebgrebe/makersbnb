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
      Rooms.add_room(@offer, 1)
      conn = PG.connect(dbname: 'makersbnb_test')
      results = conn.exec("SELECT * FROM rooms;")[2]
      expect(results['room_name']).to eq(@offer['name'])
      expect(results['description']).to eq(@offer['description'])
      expect(results['price_per_night']).to eq(@offer['price'])
      expect(results['available']).to eq(@offer['available'])
      expect(results['location']).to eq(@offer['location'])
      expect(results['owner_user_id']).to eq("1")
    end
    it 'returns "success" on success' do
      expect(Rooms.add_room(@offer, 1)[:success]).to eq true
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
        'owner_user_id' => '1'})
    end
  end

  describe '.users_offers' do
    it 'returns users offers with status' do
      user1_id = '1'
      rooms = Rooms.users_offers(user1_id)[:rooms]
      expect(rooms[0]['booking']['status']).to eq 'Requested'
      expect(rooms[1]['booking']['status']).to eq 'Not requested'
      expect(rooms[0]['booking']['booker_name']).to eq 'test_name2'
    end
  end

  describe '.users_offers_without_status' do
    it 'gives you a list of room offered by a particular user' do
      user_id = '1'
      rooms = Rooms.users_offers_without_status(user_id)
      expect(rooms[0]['room_name']).to eq 'studio flat'
      expect(rooms[1]['room_name']).to eq 'penthouse'
    end
  end

end
