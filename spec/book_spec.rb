require "spec_helper"

describe Book do

  describe("#==") do
    it("is the same book if it shares a title and author") do
      book1 = Book.new({:title => "Epicodus Stuff", :author => "Sean"})
      book2 = Book.new({:title => "Epicodus Stuff", :author => "Sean"})
      expect(book1 == book2).to(eq(true))
    end
  end
  describe(".all") do
    it("is empty at first") do
      expect(Book.all()).to(eq([]))
    end
  end
  describe("#title") do
    it("tells you its title") do
      book = Book.new({:title => 'Epicodus Stuff'})
      expect(book.title).to(eq("Epicodus Stuff"))
    end
  end
  describe("#author") do
    it("tells you its author") do
      book = Book.new({:author => 'Sean'})
      expect(book.author).to(eq("Sean"))
    end
  end
  describe("#genre") do
    it("tells you its genre") do
      book = Book.new({:genre => 'Cookbook'})
      expect(book.genre).to(eq("Cookbook"))
    end
  end
  describe("#checkout") do
    it("tells you its checkout") do
      book = Book.new({:genre => 'Cookbook'})
      expect(book.checkout).to(eq(false))
    end
  end
  describe("#save") do
    it("lets you save books to the database") do
      book = Book.new({:title => 'Epicodus Stuff', :author => 'Sean', :genre => 'Cookbook'})
      book.save
      # binding.pry
      expect(Book.all).to(eq([book]))
    end
  end
  describe("#id") do
    it("returns the id of the book") do
      book = Book.new({:title => 'Epicodus Stuff', :author => 'Sean', :genre => 'Cookbook'})
      book.save
      expect(book.id).to(be_an_instance_of(Integer))
    end
  end
  describe('.find') do
   it("finds a book based off an id") do
     test_book = Book.new({:title => 'The Hatchet', :author => 'Gary Paulsen'})
     test_book.save
     test_book2 = Book.new({:title => 'My Cool Book, Niiiice', :author => 'Cool Sara'})
     test_book2.save
     expect(Book.find(test_book2.id)).to(eq(test_book2))
   end
 end
 describe('#update') do
    it("will update a bookin the db") do
      book = Book.new({:title => "Bookin", :author => 'The DB', :genre => 'Update'})
      book.save()
      book.update({:title => "Bookin!"})
      expect(book.title()).to(eq("Bookin!"))
    end
  end
  describe("#delete") do
    it("lets you delete a book from th'db") do
      book = Book.new({:title => "Bookin", :author => 'The DB', :genre => 'Update'})
      book.save
      book2 = Book.new({:title => 'My Cool Book, Niiiice', :author => 'Cool Sara'})
      book2.save
      book.delete
      expect(Book.all()).to(eq([book2]))
    end
  end

end
