class AddSlugToCareer < ActiveRecord::Migration[5.1]
  def change
    add_column :careers, :slug, :string
    add_index :careers, :slug
  end
end
