class RenameUsageBuildingBlockEvents < ActiveRecord::Migration[5.2]
  def change
    rename_table :usage_building_block_events, :usage_code_snippet_events

    rename_column :usage_code_snippet_events, :block, :snippet
  end
end
