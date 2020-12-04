class CreateFeedbackConfig < ActiveRecord::Migration[6.0]
  def change
    create_table :feedback_configs, id: :uuid do |t|
      t.string :title
      t.jsonb :paths

      t.timestamps
    end
  end
end
