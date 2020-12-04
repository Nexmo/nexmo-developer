class AddDetailsToFeedbackFeedback < ActiveRecord::Migration[6.0]
  def change
    add_reference :feedback_feedbacks, :feedback_config, null: false, foreign_key: true, type: :uuid, null: true
    add_column :feedback_feedbacks, :path, :integer
    add_column :feedback_feedbacks, :steps, :jsonb
  end
end
