class AddRolesMaskToAdmins < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :roles_mask, :integer
  end
end
