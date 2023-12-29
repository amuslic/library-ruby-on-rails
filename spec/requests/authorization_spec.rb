require 'swagger_helper'

RSpec.describe 'authorization', type: :request do
  path '/login' do
    post('login auth') do
      tags 'Login'
      consumes 'application/json'
      produces 'application/json'  

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
            username: { type: :string },
            password: { type: :string }
        }
      }

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
end