class Loan < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :book, :user, presence: true
  validate :validate_book_copies, on: :create
  validate :validate_active_loans, on: :create
  validate :validate_book_exists, on: :create
  validate :validate_user_exists, on: :create

  before_create :set_loan_dates

  private

  def validate_book_exists
    errors.add(:book_id, 'does not exist') unless Book.exists?(book_id)
  end

  def validate_user_exists
    errors.add(:user_id, 'does not exist') unless User.exists?(user_id)
  end

  def validate_book_copies
    return unless book.present?

    errors.add(:base, 'No available copies of the book') if book.hard_copies <= 0
  end

  def validate_active_loans
    return unless user.present?

    active_loans_count = user.loans.where(active: true).count
    errors.add(:base, 'User has reached the maximum allowed active loans') if active_loans_count >= 3
  end

  def set_loan_dates
    self.loan_date = Date.today
    self.return_date = loan_date + loan_duration.days
    self.active = return_date >= Date.today
  end
end
