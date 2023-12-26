class AddPlayerIdColumnToRoster < ActiveRecord::Migration[7.0]
  def up
    add_column :rosters, :player_id, :integer unless column_exists? :rosters, :player_id
  end

  def down
    remove_column :rosters, :player_id if column_exists? :rosters, :player_id
  end
end
