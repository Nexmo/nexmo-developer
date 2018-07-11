class ChangeEventsStartAtAndEndAtToDateType < ActiveRecord::Migration[5.1]
  def change
    change_column :events, :starts_at, :date
    change_column :events, :ends_at, :date
  end
end
