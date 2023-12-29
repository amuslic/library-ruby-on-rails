class LoanApiModel
    attr_accessor :user, :book, :loan_date, :return_date
  
    def initialize(loan)
      @user = loan.user.username
      @book = loan.book.title
      @loan_date = loan.loan_date
      @return_date = loan.return_date     
    end
  end