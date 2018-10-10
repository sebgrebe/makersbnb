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
  end

  describe '.exist?' do
    it 'tells us if user already exists' do
      Users.sign_up(@email, @password, @first_name, @last_name)
      expect(Users.exist?(@email)).to eq(true)
    end
  end
end
