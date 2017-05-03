require 'sinatra'
require 'sinatra/reloader'
require './lib/book'
require 'pry'

also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "library_system"})

get('/') do
  erb(:index)
end
