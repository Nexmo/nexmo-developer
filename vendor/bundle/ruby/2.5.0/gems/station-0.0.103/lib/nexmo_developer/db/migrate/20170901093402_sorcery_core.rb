class SorceryCore < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, unique: true, null: false
      t.boolean :admin, null: false, default: false
      t.string :crypted_password
      t.string :salt
      t.string :remember_me_token
      t.datetime :remember_me_token_expires_at
      t.timestamps null: false
    end

    add_index :users, :email
    add_index :users, :remember_me_token
    add_index :users, :admin
  end
end
