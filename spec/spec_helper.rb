require 'rspec'
require 'pg'
require 'book'
require 'patron'
require 'pry'


DB = PG.connect({:dbname => 'library_system_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("TRUNCATE books, patrons, checkouts, authors, authors_books;")
  end
end
