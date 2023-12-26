class AddIndexToAwayAndHomeRosterColumns < ActiveRecord::Migration[7.0]
  def up
    add_index :matches, :away_roster_id unless index_exists? :matches, :away_roster_id
    add_index :matches, :home_roster_id unless index_exists? :matches, :home_roster_id
  end

  def down
    remove_index :matches, :away_roster_id if index_exists? :matches, :away_roster_id
    remove_index :matches, :home_roster_id if index_exists? :matches, :home_roster_id
  end
end
