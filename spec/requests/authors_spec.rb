require 'swagger_helper'

RSpec.describe 'authors', type: :request do

  path '/authors' do
    get('Get all authors') do
      tags Author
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
