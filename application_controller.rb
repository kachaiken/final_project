require 'bundler'
Bundler.require
require_relative 'models/movie.rb'

class MyApp < Sinatra::Base

  get '/' do

    erb :index

  end

  post '/results' do
    @movies = Movie.new(params["Moods"])
    erb :results

  end

end