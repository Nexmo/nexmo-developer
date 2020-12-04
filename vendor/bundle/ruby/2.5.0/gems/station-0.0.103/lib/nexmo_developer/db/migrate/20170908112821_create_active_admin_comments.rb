class CreateActiveAdminComments < ActiveRecord::Migration::Current
  def self.up
    create_table :active_admin_comments, id: :uuid do |t|
      t.string :namespace
      t.text   :body
      t.string :resource_type
      t.uuid :resource_id
      t.string :author_type
      t.uuid :author_id
      t.timestamps
    end
    add_index :active_admin_comments, [:namespace]

  end

  def self.down
    drop_table :active_admin_comments
  end
end
