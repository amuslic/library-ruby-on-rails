class CreateLoans < ActiveRecord::Migration[7.1]
  def change
    create_table :loans do |t|
      t.references :book, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :loan_date
      t.datetime :return_date
      t.integer :loan_duration

      t.timestamps
    end
  end
end
