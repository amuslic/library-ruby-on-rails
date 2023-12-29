class AddIndexToAuthorsName < ActiveRecord::Migration[7.1]
  def change
    add_index :authors, :name
  end
end
