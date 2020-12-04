class AddCityCountryToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :city, :string
    add_column :events, :country, :string, :limit => 2
  end
end
