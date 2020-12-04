class AddCodeLanguageToFeedback < ActiveRecord::Migration[5.1]
  def change
    add_column :feedback_feedbacks, :code_language, :string
    add_index :feedback_feedbacks, :code_language
  end
end
