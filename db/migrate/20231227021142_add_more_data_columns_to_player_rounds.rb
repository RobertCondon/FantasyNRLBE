class AddMoreDataColumnsToPlayerRounds < ActiveRecord::Migration[7.0]
  def up
    add_column :player_rounds, :fantasy_points_total, :integer unless column_exists?(:player_rounds, :fantasy_points_total)
    add_column :player_rounds, :field_goals, :integer unless column_exists?(:player_rounds, :field_goals)
    add_column :player_rounds, :forced_drop_out_kicks, :integer unless column_exists?(:player_rounds, :forced_drop_out_kicks)
    add_column :player_rounds, :goals, :integer unless column_exists?(:player_rounds, :goals)
    add_column :player_rounds, :hit_up_run_meters, :integer unless column_exists?(:player_rounds, :hit_up_run_meters)
    add_column :player_rounds, :offside_within_ten_meters, :integer unless column_exists?(:player_rounds, :offside_within_ten_meters)
    add_column :player_rounds, :play_the_ball_average_speed, :decimal unless column_exists?(:player_rounds, :play_the_ball_average_speed)
    rename_column :player_rounds, :grubbers, :grubber_kicks if column_exists?(:player_rounds, :grubbers)
    rename_column :player_rounds, :kicked_deads, :kicks_dead if column_exists?(:player_rounds, :kicked_deads)
    rename_column :player_rounds, :kicking_meters, :kick_meters if column_exists?(:player_rounds, :kicking_meters)
    rename_column :player_rounds, :mins_played, :minutes_played if column_exists?(:player_rounds, :mins_played)
    rename_column :player_rounds, :one_one_one_steals, :one_on_one_steal if column_exists?(:player_rounds, :one_one_one_steals)
  end

  def down
    remove_column :player_rounds, :fantasy_points_total if column_exists?(:player_rounds, :fantasy_points_total)
    remove_column :player_rounds, :field_goals if column_exists?(:player_rounds, :field_goals)
    remove_column :player_rounds, :forced_drop_out_kicks if column_exists?(:player_rounds, :forced_drop_out_kicks)
    remove_column :player_rounds, :forced_drop_outs if column_exists?(:player_rounds, :forced_drop_outs)
    remove_column :player_rounds, :goals if column_exists?(:player_rounds, :goals)
    remove_column :player_rounds, :hit_up_run_meters if column_exists?(:player_rounds, :hit_up_run_meters)
    remove_column :player_rounds, :offside_within_ten_meters if column_exists?(:player_rounds, :offside_within_ten_meters)
    remove_column :player_rounds, :play_the_ball_average_speed if column_exists?(:player_rounds, :play_the_ball_average_speed)
    rename_column :player_rounds, :grubber_kicks, :grubbers if column_exists?(:player_rounds, :grubber_kicks)
    rename_column :player_rounds, :kicks_dead, :kicked_deads if column_exists?(:player_rounds, :kicks_dead)
    rename_column :player_rounds, :kick_meters, :kicking_meters if column_exists?(:player_rounds, :kick_meters)
    rename_column :player_rounds, :minutes_played, :mins_played if column_exists?(:player_rounds, :minutes_played)
    rename_column :player_rounds, :one_on_one_steal, :one_one_one_steals if column_exists?(:player_rounds, :one_on_one_steal)
  end
end
