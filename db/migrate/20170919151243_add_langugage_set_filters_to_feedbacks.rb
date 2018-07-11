class AddLangugageSetFiltersToFeedbacks < ActiveRecord::Migration[5.1]
  def change
    add_column :feedback_feedbacks, :code_language_selected_whilst_on_page, :boolean
    add_column :feedback_feedbacks, :code_language_set_by_url, :boolean

    add_index :feedback_feedbacks, :code_language_selected_whilst_on_page, name: 'index_feedbacks_on_code_language_selected_whilst_on_page'
    add_index :feedback_feedbacks, :code_language_set_by_url, name: 'index_feedbacks_on_code_language_set_by_url'
  end
end
