class CreateFeedbackAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :feedback_authors, id: :uuid do |t|
      t.string :email, unique: true

      t.timestamps
    end
    add_index :feedback_authors, :email
  end
end
