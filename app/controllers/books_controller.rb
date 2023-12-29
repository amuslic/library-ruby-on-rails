class BooksController < ApplicationController

  # GET /books
  def index
    @books = Book.all
    @books_api_models = @books.map { |book| BookApiModel.new(book) }
    render json: @books_api_models
  end

  # GET /books/1
  def show
    begin
      @book = Book.find(params[:id])
      @books_api_model = BookApiModel.new(@book)
      render json: @books_api_model
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Book not found' }, status: :not_found
    end
  end

  # GET /books/out-of-stock
  def index_out_of_stock
    @outOfStockBooks = Book.where(hard_copies: 0)
    @outOfStockBooksApiModels = @outOfStockBooks.map { |outOfStockBook| BookApiModel.new(outOfStockBook) }
    render json: @outOfStockBooksApiModels
  end

   # GET /books/search?searchTerm=example
  def search
    searchTerm = params[:searchTerm].downcase
    @books = Book.joins(:author)
                 .where('lower(books.title) LIKE ? OR lower(authors.name) LIKE ?', "%#{searchTerm}%", "%#{searchTerm}%")
    @books_api_models = @books.map { |book| BookApiModel.new(book) }
    render json: @books_api_models
  end


end
