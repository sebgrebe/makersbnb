require 'sinatra/base'
require_relative 'lib/rooms'

class MakersBnB < Sinatra::Base

  enable :sessions

  get '/offer' do
    File.read(File.join('public', 'offer.html'))
  end

  get '/rooms' do
    File.read(File.join('public', 'rooms.html'))
  end

  get '/api/rooms' do
     Rooms.list_rooms.to_json
  end

  post '/api/book_room' do
    Rooms.book_room(params[:id]).to_json
  end

  run! if app_file == $0

end
