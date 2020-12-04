class UsageBuildingBlockEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :usage_building_block_events, id: :uuid do |t|
      t.string :language, null: false
      t.string :block, null: false
      t.string :section, null: false
      t.string :action, null: false
      t.string :ip, null: false
      t.timestamps
    end
    add_index :usage_building_block_events, :language
    add_index :usage_building_block_events, :block
    add_index :usage_building_block_events, :action
    add_index :usage_building_block_events, :ip
  end
end
