class CreateRedirects < ActiveRecord::Migration[5.1]
  def change
    create_table :redirects, id: :uuid do |t|
      t.string :url
      t.integer :uses
    end
  end
end
