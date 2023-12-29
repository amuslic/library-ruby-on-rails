require 'swagger_helper'

RSpec.describe 'books', type: :request do

  path '/books' do

    get('List all books') do
      tags Book
      response(200, 'successful') do
         
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/books/search' do

    get('Search book by author or title name') do
      tags Book
      parameter name: :searchTerm, 
      in: :query, 
      type: :string, 
      description: 'term to search by book title or author name',
      required: true

      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/books/out-of-stock' do

    get('Get books that are out of stock') do
      tags Book
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
  path '/books/{id}' do
    parameter name: 'id', 
    in: :path, 
    type: :string, 
    description: 'id of the book we want to get data for'

    get('Get book by id') do
      tags Book
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
