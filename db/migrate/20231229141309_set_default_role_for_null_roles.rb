class SetDefaultRoleForNullRoles < ActiveRecord::Migration[7.1]
  def up
    User.where(role: nil).update_all(role: 'member')
  end

  def down
  end
end