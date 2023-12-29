class LoansController < ApplicationController
  before_action :set_loan, only: %i[ show update destroy ]

  # GET /loans
  def index
    @loans = Loan.all

    render json: @loans
  end

  # GET /loans/1
  def show
    render json: @loan
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

  # PATCH/PUT /loans/1
  def update
    if @loan.update(loan_params)
      render json: @loan
    else
      render json: @loan.errors, status: :unprocessable_entity
    end
  end

  # DELETE /loans/1
  def destroy
    @loan.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def loan_params
      params.require(:loan).permit(:book_id, :user_id, :loan_date, :return_date, :loan_duration)
    end
end
