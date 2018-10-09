require 'sinatra/base'
require_relative '../lib/rooms'


class MakersBnB < Sinatra::Base

  # get '/' do
  #   erb :index
  # end

  get '/rooms' do
    File.read(File.join('frontend', 'rooms.html'))
  end

  run! if app_file == $0

end
