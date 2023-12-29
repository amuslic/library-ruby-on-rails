class AddActiveToLoans < ActiveRecord::Migration[7.1]
  def change
    add_column :loans, :active, :boolean
  end
end
