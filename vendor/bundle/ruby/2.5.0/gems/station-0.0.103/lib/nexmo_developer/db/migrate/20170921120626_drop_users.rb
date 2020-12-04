class DropUsers < ActiveRecord::Migration[5.1]
  def change
    drop_table :users
  end
end
