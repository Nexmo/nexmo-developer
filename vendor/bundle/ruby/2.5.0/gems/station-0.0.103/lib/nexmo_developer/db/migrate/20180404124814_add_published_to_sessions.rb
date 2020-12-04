class AddPublishedToSessions < ActiveRecord::Migration[5.1]
  def change
    add_column :sessions, :published, :boolean
    add_index :sessions, :published
  end
end
