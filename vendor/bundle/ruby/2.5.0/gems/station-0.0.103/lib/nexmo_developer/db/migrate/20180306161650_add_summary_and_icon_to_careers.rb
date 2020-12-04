class AddSummaryAndIconToCareers < ActiveRecord::Migration[5.1]
  def change
    add_column :careers, :summary, :string
    add_column :careers, :icon, :string
  end
end
