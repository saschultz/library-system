class Patron

  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def ==(another_name)
    self.name == another_name.name
  end

  def Patron.all
    patrons = []
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    returned_patrons.each() do |patron|
      name = patron['name']
      id = patron['id'].to_i
      patrons.push(Patron.new({:name => name, :id => id}))
    end
    patrons
  end

  def save
    result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def Patron.find(input)
    found_patron = nil
    Patron.all.each do |patron|
      if patron.id == input
        found_patron = patron
      end
    end
    found_patron
  end

  def update(attributes)
    @name = attributes[:name]
    DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id = #{self.id};")

    attributes.fetch(:book_id, []).each do |book_id|
      DB.exec("INSERT INTO checkouts (patron_id, book_id) VALUES (#{self.id}, #{book_id});")
    end
  end

  def books
    patron_books = []
    results = DB.exec("SELECT book_id FROM checkouts WHERE patron_id = #{self.id};")
    results.each do |result|
      book_id = result.fetch('book_id').to_i
      book = DB.exec("SELECT * FROM books WHERE id = #{book_id};")
      book_title = book.first.fetch('title')
      book_author = book.first.fetch('author')
      book_genre = book.first.fetch('genre')
      patron_books.push(Book.new({:title => book_title, :author => book_author, :genre => book_genre, :id => book_id}))
    end
    patron_books
  end

  def delete
    DB.exec("DELETE FROM checkouts WHERE patron_id = #{self.id};")
    DB.exec("DELETE FROM patrons WHERE id = #{self.id};")
  end

end
