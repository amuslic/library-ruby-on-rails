require 'swagger_helper'

RSpec.describe 'loans', type: :request do

  path '/loans' do
    get('Get all loans') do
      tags Loan
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
      tags Loan
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
              description: 'User id for which we want to get loans'
  
    get('Get all user loans') do
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
  
      response(404, 'User not found') do
        let(:user_id) { 'nonexistent_user_id' }
        run_test!
      end
    end
  end
end
