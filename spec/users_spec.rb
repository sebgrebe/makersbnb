require 'users'

describe Users do
  describe '.sign_up' do
    it 'allows a user to sign up to makersbnb' do
      Users.sign_up(email, password, first_name, last_name)
      conn = PG.connect(dbname: 'makersbnb_test')

      expect(result = conn.exec("SELECT * FROM users WHERE #{email}"))
    end
  end
end
