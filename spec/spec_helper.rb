require 'rspec'
require 'pg'
require 'book'


DB = PG.connect({:dbname => 'library_system_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
  end
end
