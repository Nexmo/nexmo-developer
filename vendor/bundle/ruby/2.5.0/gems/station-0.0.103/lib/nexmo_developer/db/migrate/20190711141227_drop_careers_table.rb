class DropCareersTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :careers, if_exists: true do |t|
      t.string  :title
      t.boolean :published
      t.string  :location
      t.text    :description
      t.string  :url
      t.string  :summary
      t.string  :icon
      t.string  :slug
      t.text    :description_short
      t.string  :role_group
      t.timestamps

      t.index   :published
      t.index   :role_group
      t.index   :slug
    end
  end
end
