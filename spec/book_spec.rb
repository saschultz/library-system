require "spec_helper"

describe Book do
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

end
