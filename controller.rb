require 'sinatra/base'
require_relative 'lib/rooms'

class MakersBnB < Sinatra::Base

  get '/rooms' do
    File.read(File.join('public', 'rooms.html'))
  end

  run! if app_file == $0

end
