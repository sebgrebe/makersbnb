require 'sinatra/base'
require_relative 'lib/rooms'
require_relative 'lib/users'
require_relative 'lib/bookings'

class MakersBnB < Sinatra::Base

  enable :sessions


  get '/' do
    File.read(File.join('public', 'index.html'))
  end

  get '/offer' do
    File.read(File.join('public', 'offer.html'))
  end

  get '/rooms' do
    File.read(File.join('public', 'rooms.html'))
  end

  get '/user' do
    File.read(File.join('public', 'user.html'))
  end

  get '/users/signup' do
    File.read(File.join('public', 'signup.html'))
  end

  get '/users/login' do
    File.read(File.join('public', 'login.html'))
  end


  get '/users/bookings' do
    File.read(File.join('public', 'users_bookings.html'))
  end

  get '/users/offers' do
    File.read(File.join('public', 'users_offers.html'))
  end

  get '/api/rooms' do
     Rooms.list_rooms.to_json
  end


  get '/api/users/bookings' do
    p 'help me', session[:user]
    Bookings.display_booked_rooms(session[:user]["user_id"]).to_json
  end

  get '/api/users/offers' do
    return {success: false, msg: "You need to be logged in to offer a room"}.to_json if session[:user] == nil
    @user_id = session[:user]["user_id"]
    Rooms.users_offers(@user_id).to_json
  end

  post '/api/users/offers/confirm' do
    Bookings.confirm(params[:booking_id]).to_json
  end

  post '/api/users/offers/decline' do
    Bookings.decline(params[:booking_id]).to_json
  end

  post '/api/login' do
    login = params[:login]
    result = Users.authenticate(login['email'], login['password'])
    if result[:success]
      session[:user] = result[:user]
    end
    return result.to_json
  end

  post '/api/signup' do
    signup = params[:signup]
    result = Users.sign_up(signup['email'], signup['password'], signup['first_name'], signup['last_name'])
    if result[:success]
      session[:user] = result[:user]
    end
    return result.to_json
  end

  post '/api/book_room' do
    return {success: false, msg: "You need to be logged in to book a room"}.to_json if session[:user] == nil
    @user_id = session[:user]["user_id"]
    Bookings.book_room(params[:id], @user_id).to_json
  end

  post '/api/offer_room' do
    return {success: false, msg: "You need to be logged in to offer a room"}.to_json if session[:user] == nil
    @offer = params[:offer]
    @user_id = session[:user]["user_id"]
    Rooms.add_room(@offer, @user_id).to_json
  end

  run! if app_file == $0

end
