class AddRoleGroupToCareers < ActiveRecord::Migration[5.1]
  def change
    add_column :careers, :role_group, :string
    add_index :careers, :role_group
  end
end
