require 'sinatra'
require 'sinatra/reloader'
require './lib/book'
require 'pry'
require 'pg'

also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "library_system"})

get("/") do
  erb(:index)
end

get("/librarian") do
  @books = Book.all
  erb(:librarian)
end

post("/add_book") do
  title = params.fetch('title')
  author = params.fetch('author')
  genre = params.fetch('genre')
  book = Book.new({:title => title, :author => author, :genre => genre})
  book.save
  @books = Book.all
  erb(:librarian)
end

get '/catalog/:id' do
  @book = Book.find(params.fetch("id").to_i)
  erb :edit_book
end

patch '/:id/edit_book' do
  book = Book.find(params.fetch("id").to_i)
  title = params.fetch('title')
  book.update({:title => title})
  @books = Book.all

  erb :librarian
end
