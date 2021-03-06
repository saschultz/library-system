require "spec_helper"


describe(Patron) do

  describe("#==") do
    it("is the same patron if it shares a name") do
      patron1 = Patron.new({:name => "Randy Jackson"})
      patron2 = Patron.new({:name => "Randy Jackson"})
      expect(patron1 == patron2).to(eq(true))
    end
  end

  describe(".all") do
    it("returns all library patrons") do
      patron1 = Patron.new({:name => "Randy Jackson"})
      patron2 = Patron.new({:name => "Cool Patient"})
      patron1.save
      patron2.save
      expect(Patron.all).to(eq([patron1, patron2]))
    end
  end

  describe("#save") do
    it("saves a patron to the database") do
      patron1 = Patron.new({:name => "Randy Jackson"})
      patron2 = Patron.new({:name => "Cool Patient"})
      patron1.save
      patron2.save
      expect(Patron.all).to(eq([patron1, patron2]))
    end
  end

  describe("#update") do
    it("updates the name of a patron") do
      patron1 = Patron.new({:name => "Randy Jackson"})
      patron1.save
      patron1.update({:name => "Janet Jackson"})
      expect(patron1.name).to(eq("Janet Jackson"))
    end
    it 'lets you add a book to a patron' do
      book = Book.new({:title => "Goosebumps", :author => "Sean?", :genre => 'Children'})
      book.save
      patron = Patron.new({:name => "Randy Jackson"})
      patron.save
      patron.update({:book_id => [book.id]})
      expect(patron.books).to(eq([book]))
    end
  end

  describe '#books' do
    it 'returns all the books of a particular patron has checked out' do
      book = Book.new({:title => "Goosebumps", :genre => 'Children'})
      book.save
      patron = Patron.new({:name => "Randy Jackson"})
      patron.save
      book2 = Book.new({:title => "Catcher in the Rye", :genre => 'Fiction'})
      book2.save
      patron.update({:book_id => [book.id]})
      patron.update({:book_id => [book2.id]})
    end
  end

  describe("#delete") do
    it("removes a patron from the database") do
      patron1 = Patron.new({:name => "Randy Jackson"})
      patron2 = Patron.new({:name => "Cool Patient"})
      patron1.save
      patron2.save
      patron1.delete
      expect(Patron.all).to(eq([patron2]))
    end
  end

end
