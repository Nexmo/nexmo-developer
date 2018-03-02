class CreateOauthUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :oauth_users, id: :uuid do |t|
      t.string :provider
      t.string :uid
      t.json :details

      t.timestamps
    end
    add_index :oauth_users, :provider
    add_index :oauth_users, :uid
  end
end
