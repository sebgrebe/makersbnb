require 'bcrypt'

class Users
  def self.sign_up(email, password, first_name, last_name)
    return {success: false} if self.exist?(email)
    connect_database
    pw_encrypted = BCrypt::Password.create(password)
    user = @connection.exec("INSERT INTO users (email, password, first_name, last_name) VALUES ('#{email}', '#{pw_encrypted}', '#{first_name}', '#{last_name}') RETURNING user_id, first_name" )[0]
    return {:success => true, :user => user}
  end

  def self.authenticate(email,password)
    connect_database
    user = @connection.exec("SELECT * FROM users WHERE email='#{email}'")
    return {:success => false, msg: 'User does not exist'} if user.ntuples == 0
    return {:success => false, msg: 'Wrong password'} if BCrypt::Password.new(user[0]['password']) != password
    return {:success => true, :user => user[0]}
  end

  def self.exist?(email)
    connect_database
    result = @connection.exec("SELECT * FROM users WHERE email='#{email}'")
    return true if (result.ntuples > 0)
    return false
  end

  def self.connect_database
    if ENV['ENV'] == 'test'
      @connection = PG.connect(dbname: 'makersbnb_test')
    else
      @connection = PG.connect(dbname: 'makersbnb')
    end
  end
end
