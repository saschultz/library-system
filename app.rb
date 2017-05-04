require 'sinatra'
require 'sinatra/reloader'
require './lib/book'
require './lib/patron'
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

get '/patron' do
  erb :patron
end

post '/add_patron' do
  name = params.fetch('name')
  Patron.new({:name => name}).save
  @patrons = Patron.all
  erb :patron_list
end

get '/patron_list' do
  @patrons = Patron.all
  erb :patron_list
end

get '/patron/:id' do
  @patron = Patron.find(params.fetch("id").to_i)
  @results = []
  @checked_out_books = DB.exec("SELECT book_id FROM checkouts WHERE patron_id = #{params.fetch("id").to_i};")
  erb :patron_interface
end

get '/:id/search' do

  @patron = Patron.find(params.fetch("id").to_i)
  @results = Book.find_by(params.fetch('type'), params.fetch('value'))
  @checked_out_books = DB.exec("SELECT book_id FROM checkouts WHERE patron_id = #{params.fetch('id').to_i};")
  erb :patron_interface
end

post '/:id/checkout' do
  @patron = Patron.find(params.fetch("id").to_i)
  @patron_id = params.fetch("id").to_i
  @results = []
  @checkout_selected = params.fetch("checkout")
  @checkout_selected.each do |selected|
    @book_id = selected.to_i
    DB.exec("INSERT INTO checkouts (patron_id, book_id) VALUES (#{@patron_id}, #{@book_id});")
  end
  @checked_out_books = DB.exec("SELECT book_id FROM checkouts WHERE patron_id = #{params.fetch("id").to_i};")
  erb :patron_interface
end

patch '/:id/edit_patron' do
  @patron = Patron.find(params.fetch("id").to_i)
  name = params.fetch('name')
  @patron.update({:name => name})
  @results = []
  @checked_out_books = DB.exec("SELECT book_id FROM checkouts WHERE patron_id = #{params.fetch("id").to_i};")
  erb :patron_interface
end

delete '/:id/edit_patron' do
  @patron = Patron.find(params.fetch("id").to_i)
  @patron.delete
  @patrons = Patron.all
  erb :patron_list
end

post("/add_book") do
  title = params.fetch('title')
  author = params.fetch('author')
  genre = params.fetch('genre')
  Book.new({:title => title, :author => author, :genre => genre}).save
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

delete '/:id/edit_book' do
  book = Book.find(params.fetch("id").to_i)
  book.delete
  @books = Book.all
  erb :librarian
end
