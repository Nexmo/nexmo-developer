class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions, id: :uuid do |t|
      t.string :title
      t.text :description
      t.string :author
      t.uuid :event_id
      t.string :video_url

      t.timestamps
    end
  end
end
