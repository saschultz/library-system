class Book

  attr_accessor :title, :author, :genre, :checkout, :id

  def initialize(attributes)
    @title = attributes[:title]
    @author = attributes[:author]
    @genre = attributes[:genre]
    @checkout = false
    @id = attributes[:id]
  end

  def ==(another_book)
    self.title == another_book.title && self.author == another_book.author
  end

  def Book.all
    books = []
    returned_books = DB.exec("SELECT * FROM books;")
    returned_books.each() do |book|
      title = book['title']
      author = book['author']
      genre = book['genre']
      id = book['id'].to_i
      books.push(Book.new({:title => title, :author => author, :genre => genre, :id => id}))
    end
    books
  end

  def save
    result = DB.exec("INSERT INTO books (title, author, genre, checkout) VALUES ('#{@title}', '#{@author}', '#{@genre}', #{@checkout}) RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def Book.find(input)
    found_book = nil
    Book.all.each do |book|
      if book.id == input
        found_book = book
      end
    end
    found_book
  end

  def patrons
    book_patrons = []
    results = DB.exec("SELECT patron_id FROM checkouts WHERE book_id = #{self.id};")
    results.each do |result|
      patron_id = result.fetch('patron_id').to_i
      patron = DB.exec("SELECT * FROM patrons WHERE id = #{patron_id};")
      patron_name = patron.first.fetch('name')
      book_patrons.push(Patron.new({:name => patron_name, :id => patron_id}))
    end
    book_patrons
  end

  def update(attributes)
    @title = attributes[:title]
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{self.id};")

    attributes.fetch(:patron_id, []).each do |patron_id|
      DB.exec("INSERT INTO checkouts (patron_id, book_id) VALUES (#{patron_id}, #{self.id});")
    end
  end

  def delete
    DB.exec("DELETE FROM books WHERE id = #{self.id};")
  end

  def Book.find_by(field, value)
    books = []
    returned_books = DB.exec("SELECT * FROM books WHERE #{field} = '#{value}' ORDER BY #{field} DESC;")
    returned_books.each do |book|
      title = book['title']
      author = book['author']
      genre = book['genre']
      id = book['id'].to_i
      books.push(Book.new({:title => title, :author => author, :genre => genre, :id => id}))
    end
    books
  end

end
