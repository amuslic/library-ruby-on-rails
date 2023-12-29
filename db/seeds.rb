require 'faker'

# Seed Authors
5.times do
  Author.create(name: Faker::Book.unique.author)
end

# Seed Books
10.times do
  author = Author.order('RANDOM()').first
  Book.create(
    title: Faker::Book.title,
    hard_copies: Faker::Number.between(from: 0, to: 10),
    author: author
  )
end
2.times do
  author = Author.order('RANDOM()').first
  Book.create(
    title: Faker::Book.title,
    hard_copies: 0,
    author: author
  )
end

# Seed Users
5.times do
  role = ['employee', 'member'].sample
  User.create(
    username: Faker::Internet.unique.username,
    password: 'password',
    role: role
  )
end

# Seed Loans
10.times do
  book = Book.order('RANDOM()').first
  user = User.order('RANDOM()').first
  Loan.create(
    book: book,
    user: user,
    loan_date: Faker::Date.between(from: 1.year.ago, to: Date.today),
    return_date: Faker::Date.between(from: Date.today, to: 1.year.from_now),
    loan_duration: Faker::Number.between(from: 1, to: 30) 
  )
end