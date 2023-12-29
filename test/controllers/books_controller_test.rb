require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = Book.create(
      title: 'Sample Book Title',
      hard_copies: 5,
      author: Author.create(name: 'Sample Author')
    )
  end

  test "should get index" do
    get books_url, as: :json
    assert_response :success
  end

  test "should show book" do
    get book_url(@book), as: :json
    assert_response :success
  end

  test "should get out-of-stock books" do
    get '/books/out-of-stock', as: :json
    assert_response :success
  end

  test "should search books" do
    get '/books/search?searchTerm=C', as: :json
    assert_response :success
  end
end
