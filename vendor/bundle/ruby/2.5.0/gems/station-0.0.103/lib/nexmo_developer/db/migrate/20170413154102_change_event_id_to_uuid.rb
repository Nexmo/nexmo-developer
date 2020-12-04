class ChangeEventIdToUuid < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :id
    add_column :events, :id, :uuid, default: "uuid_generate_v4()", null: false
    execute "ALTER TABLE events ADD PRIMARY KEY (id);"
  end
end
