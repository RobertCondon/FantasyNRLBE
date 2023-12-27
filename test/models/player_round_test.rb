# == Schema Information
#
# Table name: player_rounds
#
#  id                          :bigint           not null, primary key
#  all_run_meters              :integer
#  all_runs                    :integer
#  average_play_the_ball_speed :string
#  bomb_kicks                  :integer
#  conversion_attempts         :integer
#  conversions                 :integer
#  cross_field_kicks           :integer
#  dummy_half_run_meters       :integer
#  dummy_half_runs             :integer
#  dummy_passes                :integer
#  fantasy_points_total        :integer
#  field_goals                 :integer
#  forced_drop_out_kicks       :integer
#  forty_twenties              :integer
#  goal_conversion_rate        :string
#  goals                       :integer
#  grubber_kicks               :integer
#  handling_errors             :integer
#  hit_up_run_meters           :integer
#  hit_ups                     :integer
#  ineffective_tackles         :integer
#  inside_10_meters            :integer
#  intercepts                  :integer
#  kick_meters                 :integer
#  kick_return_meters          :integer
#  kicks                       :integer
#  kicks_dead                  :integer
#  kicks_defused               :integer
#  line_break_assists          :integer
#  line_breaks                 :integer
#  line_engaged_runs           :integer
#  minutes_played              :string
#  missed_tackles              :integer
#  number                      :integer
#  offloads                    :integer
#  offside_within_ten_meters   :integer
#  on_report                   :integer
#  one_on_one_lost             :integer
#  one_on_one_steal            :integer
#  one_point_field_goals       :integer
#  passes                      :integer
#  passes_to_run_ratio         :string
#  penalties                   :integer
#  penalty_goals               :integer
#  play_the_ball               :integer
#  play_the_ball_average_speed :decimal(, )
#  player_errors               :integer
#  points                      :integer
#  position                    :string
#  post_contact_meters         :integer
#  receipts                    :integer
#  ruck_infringements          :integer
#  send_offs                   :integer
#  sin_bins                    :integer
#  stint_one                   :string
#  stint_two                   :string
#  tackle_breaks               :integer
#  tackle_efficiency           :string
#  tackles_made                :integer
#  total_points                :integer
#  tries                       :integer
#  try_assists                 :integer
#  twenty_forties              :integer
#  two_point_field_goals       :integer
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  player_id                   :bigint
#  roster_id                   :bigint
#  team_id                     :bigint
#
require "test_helper"

class PlayerRoundTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
