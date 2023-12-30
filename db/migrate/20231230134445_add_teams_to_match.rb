class AddTeamsToMatch < ActiveRecord::Migration[7.0]
  def up
    add_column :matches, :home_team_id, :integer unless column_exists?(:matches, :home_team_id)
    add_column :matches, :away_team_id, :integer unless column_exists?(:matches, :away_team_id)
    add_index :matches, :home_team_id unless index_exists?(:matches, :home_team_id)
    add_index :matches, :away_team_id unless index_exists?(:matches, :away_team_id)
  end

  def down
    remove_column :matches, :home_team_id if column_exists?(:matches, :home_team_id)
    remove_column :matches, :away_team_id if column_exists?(:matches, :away_team_id)
    remove_index :matches, :home_team_id if index_exists?(:matches, :home_team_id)
    remove_index :matches, :away_team_id if index_exists?(:matches, :away_team_id)
  end
end
