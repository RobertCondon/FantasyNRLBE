class CreatePlayerRounds < ActiveRecord::Migration[7.0]
  def up
    create_table :player_rounds do |t|
      t.bigint :player_id
      t.bigint :team_id
      t.bigint :roster_id
      t.integer :number
      t.string :position
      t.string :mins_played
      t.integer :points
      t.integer :tries
      t.integer :conversions
      t.integer :conversion_attempts
      t.integer :penalty_goals
      t.string :goal_conversion_rate
      t.integer :one_point_field_goals
      t.integer :two_point_field_goals
      t.integer :total_points
      t.integer :all_runs
      t.integer :all_run_meters
      t.integer :kick_return_meters
      t.integer :post_contact_meters
      t.integer :line_breaks
      t.integer :line_break_assists
      t.integer :try_assists
      t.integer :line_engaged_runs
      t.integer :tackle_breaks
      t.integer :hit_ups
      t.integer :play_the_ball
      t.string :average_play_the_ball_speed
      t.integer :dummy_half_runs
      t.integer :dummy_half_run_meters
      t.integer :one_one_one_steals
      t.integer :offloads
      t.integer :dummy_passes
      t.integer :passes
      t.integer :receipts
      t.string :passes_to_run_ratio
      t.string :tackle_efficiency
      t.integer :tackles_made
      t.integer :missed_tackles
      t.integer :ineffective_tackles
      t.integer :intercepts
      t.integer :kicks_defused
      t.integer :kicks
      t.integer :kicking_meters
      t.integer :forced_drop_outs
      t.integer :bomb_kicks
      t.integer :grubbers
      t.integer :forty_twenties
      t.integer :twenty_forties
      t.integer :cross_field_kicks
      t.integer :kicked_deads
      t.integer :errors
      t.integer :handling_errors
      t.integer :one_on_one_lost
      t.integer :penalties
      t.integer :ruck_infringements
      t.integer :inside_10_meters
      t.integer :on_report
      t.integer :sin_bins
      t.integer :send_offs
      t.string :stint_one
      t.string :stint_two

      t.timestamps
    end unless table_exists?(:player_rounds)
  end

  def down
    drop_table :player_rounds
  end
end
