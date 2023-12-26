class ChangePlayerTeamToIdColumn < ActiveRecord::Migration[7.0]
  def up
    remove_column :players, :team if column_exists? :players, :team
    add_column :players, :team_id, :integer unless column_exists? :players, :team_id
  end

  def down
    remove_column :players, :team_id if column_exists? :players, :team_id
    add_column :players, :team, :string unless column_exists? :players, :team
  end
end
