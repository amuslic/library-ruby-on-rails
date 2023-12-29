require 'swagger_helper'

RSpec.describe 'users', type: :request do

  path '/users' do
    get('Get all users') do
      tags User
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
  path '/users/{id}' do
    parameter name: 'id',
    in: :path,
    type: :string,
    description: 'id of the user we want to fetch'

    get('Get user by id') do
      tags User
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
