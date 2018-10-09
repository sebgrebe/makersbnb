require 'sinatra/base'
require_relative 'lib/rooms'

class MakersBnB < Sinatra::Base
  set :static, true

  set :public_folder, '/public'

  # get '/' do
  #   erb :index
  # end

  # get '/src/rooms.js' do
  #   File.read(File.join('src', 'rooms.js'))
  # end

  get '/rooms' do
    File.read(File.join('public', 'rooms.html'))
  end

  # get '/api/rooms' do
  #   return rooms.list
  # end
  #
  # post '/api/book_room' do
  #
  # end
  #

  run! if app_file == $0

end
