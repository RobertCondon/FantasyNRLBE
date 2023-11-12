class AddRosterModel < ActiveRecord::Migration[7.0]
  def up
    create_table :rosters do |t|
      t.bigint :team_id

      t.timestamps
    end unless table_exists? :rosters
  end

  def down
    drop_table :rosters if table_exists? :rosters
  end
end
