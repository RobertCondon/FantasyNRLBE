class CreateTeams < ActiveRecord::Migration[7.0]
  def up
    create_table :teams do |t|
      t.string :name
      t.string :short_name
      t.integer :ladder_position

      t.timestamps
    end
  end

  def down
    drop_table :teams if table_exists? :teams
  end
end
