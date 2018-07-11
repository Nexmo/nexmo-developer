class AddApiSecretToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :nexmo_developer_api_secret, :string

    User.reset_column_information

    User.all.each do |user|
      user.generate_nexmo_developer_api_secret
      user.save!
    end

    change_column :users, :nexmo_developer_api_secret, :string, null: false
  end

  def down
    remove_column :users, :nexmo_developer_api_secret
  end
end
