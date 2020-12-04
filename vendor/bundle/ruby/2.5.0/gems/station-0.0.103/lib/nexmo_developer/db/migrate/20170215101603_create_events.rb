class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :description
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.string :url

      t.timestamps
    end
    add_index :events, :starts_at
    add_index :events, :ends_at
  end
end
