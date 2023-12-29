class BookApiModel
    attr_accessor :id, :title, :copies, :author_name
  
    def initialize(book)
      @id = book.id
      @title = book.title
      @copies = book.hard_copies
      @author_name = book.author.name if book.author
    end
  end