class ChangeBelongsToCorrectly < ActiveRecord::Migration[7.0]
  def up
    # add_column :players, :team_id, :bigint
    # add_column :matches, :home_team_id, :bigint
    # add_column :matches, :away_team_id, :bigint
    # remove_column :players, :team if column_exists? :players, :team
    # remove_column :matches, :home_team
    # remove_column :matches, :away_team
  end

  def down

  end
end
