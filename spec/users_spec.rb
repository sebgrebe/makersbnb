require 'users'

describe Users do

  before(:each) {
    @email = 'maker@gmail.com'
    @password = '1234rt'
    @first_name = 'Vu'
    @last_name = 'Le'
  }

  describe '.sign_up' do
    it 'allows a user to sign up to makersbnb' do
      Users.sign_up(@email, @password, @first_name, @last_name)
      conn = PG.connect(dbname: 'makersbnb_test')
      result = conn.exec("SELECT * FROM users WHERE email='#{@email}'")[0]
      expect(result['email']).to eq(@email)
    end
    it 'returns success message and user' do
      result = Users.sign_up(@email, @password, @first_name, @last_name)
      expect(result[:success]).to eq(true)
      expect(result[:user]['first_name']).to eq(@first_name)
    end
    it 'its throws an error if user already exists in the db' do
      Users.sign_up(@email, @password, @first_name, @last_name)
      expect(Users.sign_up(@email, @password, @first_name, @last_name)).to eq({success: false})
    end
  end

  describe '.authenticate' do
    it 'allows users to login' do
      Users.sign_up(@email, @password, @first_name, @last_name)
      result = Users.authenticate(@email, @password)
      expect(result[:success]).to eq(true)
      expect(result[:user]['first_name']).to eq(@first_name)
    end
    it 'returns success as false if password wrong' do
      Users.sign_up(@email, @password, @first_name, @last_name)
      result = Users.authenticate(@email, "wrong password")
      expect(result[:success]).to eq(false)
      expect(result[:msg]).to eq("Wrong password")
    end
    it 'returns success as false if user does not exist' do
      Users.sign_up(@email, @password, @first_name, @last_name)
      result = Users.authenticate("I do not think therefore I do not exist", @password)
      expect(result[:success]).to eq(false)
      expect(result[:msg]).to eq("User does not exist")
    end
  end

  describe '.exist?' do
    it 'tells us if user already exists' do
      Users.sign_up(@email, @password, @first_name, @last_name)
      expect(Users.exist?(@email)).to eq(true)
    end
  end

end
