require 'sinatra'
require 'sinatra/reloader'
require './lib/book'
require 'pry'
require 'pg'

also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "library_system"})

get('/') do
  @books = Book.all
  erb(:index)
end

post("/add_book") do
  title = params.fetch('title')
  author = params.fetch('author')
  genre = params.fetch('genre')
  book = Book.new({:title => title, :author => author, :genre => genre})
  book.save
  @books = Book.all
  erb(:index)
end
