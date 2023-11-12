class CreateMatches < ActiveRecord::Migration[7.0]
  def up
    create_table :matches do |t|
      t.integer :away_roster_id
      t.integer :home_roster_id
      t.string :score
      t.integer :round
      t.datetime :date

      t.timestamps
    end
  end

  def down
    drop_table :matches if table_exists? :matches
  end
end
