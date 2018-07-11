class CreateCareers < ActiveRecord::Migration[5.1]
  def change
    create_table :careers, id: :uuid do |t|
      t.string :title
      t.boolean :published
      t.string :location
      t.text :description
      t.string :url

      t.timestamps
    end
    add_index :careers, :published
  end
end
