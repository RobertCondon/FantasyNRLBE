class AddMoreDataColumnsToPlayerModel < ActiveRecord::Migration[7.0]
  def up
    add_column :players, :fantasy_points_total, :integer unless column_exists?(:players, :fantasy_points_total)
    add_column :players, :fantasy_points_average, :decimal unless column_exists?(:players, :fantasy_points_average)
    add_column :players, :cost, :integer unless column_exists?(:players, :cost)
    add_column :players, :owned_by, :decimal unless column_exists?(:players, :owned_by)
    add_column :players, :nrl_id, :integer unless column_exists?(:players, :nrl_id)
  end

  def down
    remove_column :players, :fantasy_points_total if column_exists?(:players, :fantasy_points_total)
    remove_column :players, :fantasy_points_average if column_exists?(:players, :fantasy_points_average)
    remove_column :players, :cost if column_exists?(:players, :cost)
    remove_column :players, :owned_by if column_exists?(:players, :owned_by)
    remove_column :players, :nrl_id if column_exists?(:players, :nrl_id)
  end
end
