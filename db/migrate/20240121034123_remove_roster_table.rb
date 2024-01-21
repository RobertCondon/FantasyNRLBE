class RemoveRosterTable < ActiveRecord::Migration[7.0]
  def up
    remove_index :matches, :home_roster_id if index_exists?(:matches, :home_roster_id)
    remove_index :matches, :away_roster_id if index_exists?(:matches, :away_roster_id)
    remove_column :matches, :home_roster_id if column_exists?(:matches, :home_roster_id)
    remove_column :matches, :away_roster_id if column_exists?(:matches, :away_roster_id)
    remove_column :player_rounds , :roster_id if column_exists?(:player_rounds, :roster_id)

    drop_table :rosters if table_exists?(:rosters)
  end

  def down

    create_table "rosters", force: :cascade do |t|
      t.bigint "team_id"
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["team_id"], name: "index_rosters_on_team_id"
    end

    add_column :player_rounds, :roster_id, :integer

    add_column :matches, :away_roster_id, :integer
    add_column :matches, :home_roster_id, :integer

    add_index :matches, :away_roster_id
    add_index :matches, :home_roster_id
  end
end
