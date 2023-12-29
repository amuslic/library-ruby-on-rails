require 'swagger_helper'

RSpec.describe 'loans', type: :request do

  path '/loans' do

    get('list loans') do
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

    post('Create a new loan') do
      tags 'Loan'
      consumes 'application/json'  
      parameter name: :loan, in: :body, schema: {          
      type: :object,          
      properties: {            
        user_id: { type: :string },            
        book_id: { type: :string },
        loan_duration: { type: :integer }   
      },          
      required: %w[name model]  
      }      
      produces 'application/json'  
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

  
  path '/loans/users/{user_id}' do
    parameter name: 'user_id', 
    in: :path, 
    type: :string,
    description: 'user_id'

    get('index_by_user loan') do
      tags Loan
      response(200, 'successful') do
        let(:user_id) { '123' }
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
