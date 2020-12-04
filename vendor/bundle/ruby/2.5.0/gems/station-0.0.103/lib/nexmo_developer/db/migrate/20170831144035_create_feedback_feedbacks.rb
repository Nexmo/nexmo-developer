class CreateFeedbackFeedbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :feedback_feedbacks, id: :uuid do |t|
      t.string :sentiment, null: false
      t.uuid :resource_id, null: false
      t.uuid :owner_id, null: false
      t.string :owner_type, null: false
      t.string :ip, null: false
      t.text :comment

      t.timestamps
    end
    add_index :feedback_feedbacks, :sentiment
    add_index :feedback_feedbacks, :resource_id
    add_index :feedback_feedbacks, [:owner_id, :owner_type]
    add_index :feedback_feedbacks, :ip
  end
end
