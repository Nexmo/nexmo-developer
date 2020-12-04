class AddResolvedToFeedbackFeedbacks < ActiveRecord::Migration[5.1]
  def change
    add_column :feedback_feedbacks, :resolved, :boolean, default: false, null: false
    add_index :feedback_feedbacks, :resolved
  end
end
