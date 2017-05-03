class Book

  attr_accessor :title, :author, :genre, :checkout

  def initialize(attributes)
    @title = attributes[:title]
    @author = attributes[:author]
    @genre = attributes[:genre]
    @checkout = false
  end

  def Book.all
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      title = book[:title]
      author = book[:author]
      genre = book[:genre]
      books.push(Book.new({:title => title, :author => author, :genre => genre}))
    end
    books
  end

end
