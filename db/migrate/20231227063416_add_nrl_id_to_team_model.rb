class AddNrlIdToTeamModel < ActiveRecord::Migration[7.0]
  def up
    add_column :teams, :nrl_id, :integer unless column_exists?(:teams, :nrl_id)
  end

  def down
    remove_column :teams, :nrl_id if column_exists?(:teams, :nrl_id)
  end
end
