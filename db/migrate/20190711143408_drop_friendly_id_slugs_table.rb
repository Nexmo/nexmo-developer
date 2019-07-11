class DropFriendlyIdSlugsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :friendly_id_slugs, if_exists: true do |t|
      t.string   :slug,           :null => false
      t.integer  :sluggable_id,   :null => false
      t.string   :sluggable_type, :limit => 50
      t.string   :scope
      t.datetime :created_at

      t.index :sluggable_id
      t.index [:slug, :sluggable_type], length: { slug: 140, sluggable_type: 50 }
      t.index [:slug, :sluggable_type, :scope], length: { slug: 70, sluggable_type: 50, scope: 70 }, unique: true
      t.index :sluggable_type
    end
  end
end
