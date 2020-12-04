class CreateFeedbackResources < ActiveRecord::Migration[5.1]
  def change
    create_table :feedback_resources, id: :uuid do |t|
      t.string :uri, null: false

      t.timestamps
    end
    add_index :feedback_resources, :uri, unique: true
  end
end
