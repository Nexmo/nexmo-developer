class AddDescriptionShortToCareers < ActiveRecord::Migration[5.1]
  def change
    add_column :careers, :description_short, :text
  end
end
