class LoansController < ApplicationController
  include TokenDecoder

  before_action :authorize_employee, only: [:index, :create]
  before_action :authorize_employee_or_member, only: [:index_by_user]
  before_action :set_loan, only: %i[ show update destroy ]

  # GET /loans
  def index
    @loans = Loan.all
    @user_loans_api_models = @loans.map { |loan| LoanApiModel.new(loan) }
    render json: @loans
  end

  # GET/loans/users/:user_id
  def index_by_user
    @user_loans = Loan.where(user_id: params[:user_id]).order(loan_date: :desc)
    @user_loans_api_models = @user_loans.map { |user_loan| LoanApiModel.new(user_loan) }

    render json: @user_loans_api_models
  end

  # POST /loans
  def create
    @loan = Loan.new(loan_params)

    if @loan.save
      @loan_api_model = LoanApiModel.new(@loan)
      render json: @loan_api_model, status: :created, location: @loan
    else
      render json: @loan.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def loan_params
      params.require(:loan).permit(:book_id, :user_id, :loan_date, :loan_duration)
    end

    def authorize_employee
      decoded_token = decode_token()

      unless decoded_token && decoded_token[:role] == 'employee'
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  
    def authorize_employee_or_member
      decoded_token = decode_token()

      unless decoded_token && (decoded_token[:role] == 'employee' || decoded_token[:role] == 'member')
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
end
