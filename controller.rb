require 'sinatra/base'
require_relative 'lib/rooms'
require_relative 'lib/users'

class MakersBnB < Sinatra::Base

  enable :sessions

  get '/offer' do
    File.read(File.join('public', 'offer.html'))
  end

  get '/rooms' do
    File.read(File.join('public', 'rooms.html'))
  end

  get '/users/signup' do
    File.read(File.join('public', 'signup.html'))
  end

  get '/api/rooms' do
     Rooms.list_rooms.to_json
  end

  post '/api/signup' do
    signup = params[:signup]
    Users.sign_up(signup['email'], signup['password'], signup['first_name'], signup['last_name']).to_json
  end

  post '/api/book_room' do
    Rooms.book_room(params[:id]).to_json
  end

  post '/api/offer_room' do
    @offer = params[:offer]
    Rooms.add_room(@offer).to_json
  end


  run! if app_file == $0

end
