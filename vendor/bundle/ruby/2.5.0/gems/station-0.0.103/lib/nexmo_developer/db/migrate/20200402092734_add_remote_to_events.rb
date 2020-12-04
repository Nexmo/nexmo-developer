class AddRemoteToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :remote, :boolean, default: false
  end
end
