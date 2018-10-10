require 'bcrypt'

class Users
  def self.sign_up(email, password, first_name, last_name)
    connect_database
    pw_encrypted = BCrypt::Password.create(password)
    result = @connection.exec("INSERT INTO users (email, password, first_name, last_name) VALUES ('#{email}', '#{pw_encrypted}', '#{first_name}', '#{last_name}') RETURNING user_id, first_name" )
  end

  def self.connect_database
    if ENV['ENV'] == 'test'
      @connection = PG.connect(dbname: 'makersbnb_test')
    else
      @connection = PG.connect(dbname: 'makersbnb')
    end
  end
end
