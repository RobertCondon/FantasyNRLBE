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
#  forced_drop_outs            :integer
#  forty_twenties              :integer
#  goal_conversion_rate        :string
#  grubbers                    :integer
#  handling_errors             :integer
#  hit_ups                     :integer
#  ineffective_tackles         :integer
#  inside_10_meters            :integer
#  intercepts                  :integer
#  kick_return_meters          :integer
#  kicked_deads                :integer
#  kicking_meters              :integer
#  kicks                       :integer
#  kicks_defused               :integer
#  line_break_assists          :integer
#  line_breaks                 :integer
#  line_engaged_runs           :integer
#  mins_played                 :string
#  missed_tackles              :integer
#  number                      :integer
#  offloads                    :integer
#  on_report                   :integer
#  one_on_one_lost             :integer
#  one_one_one_steals          :integer
#  one_point_field_goals       :integer
#  passes                      :integer
#  passes_to_run_ratio         :string
#  penalties                   :integer
#  penalty_goals               :integer
#  play_the_ball               :integer
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
FactoryBot.define do
  factory :player_round do
    all_run_meters { 1 }
    all_runs { 1 }
    average_play_the_ball_speed { 1 }
    bomb_kicks { 1 }
    conversion_attempts { 1 }
    conversions { 1 }
    cross_field_kicks { 1 }
    dummy_half_run_meters { 1 }
    dummy_half_runs { 1 }
    dummy_passes { 1 }
    forced_drop_outs { 1 }
    forty_twenties { 1 }
    goal_conversion_rate { 1 }
    grubbers { 1 }
    handling_errors { 1 }
    hit_ups { 1 }
    ineffective_tackles { 1 }
    inside_10_meters { 1 }
    intercepts { 1 }
    kick_return_meters { 1 }
    kicked_deads { 1 }
    kicking_meters { 1 }
    kicks { 1 }
    kicks_defused { 1 }
    line_break_assists { 1 }
    line_breaks { 1 }
    line_engaged_runs { 1 }
    mins_played { 1 }
    missed_tackles { 1 }
    number { 1 }
    offloads { 1 }
    on_report { 1 }
    one_on_one_lost { 1 }
    one_one_one_steals { 1 }
    one_point_field_goals { 1 }
    passes { 1 }
    passes_to_run_ratio { 1 }
    penalties { 1 }
    penalty_goals { 1 }
    play_the_ball { 1 }
    player_errors { 1 }
    points { 1 }
    position { 1 }
    post_contact_meters { 1 }
    receipts { 1 }
    ruck_infringements { 1 }
    send_offs { 1 }
    sin_bins { 1 }
    stint_one { 1 }
    stint_two { 1 }
    tackle_breaks { 1 }
    tackle_efficiency { 1 }
    tackles_made { 1 }
    total_points { 1 }
    tries { 1 }
    try_assists { 1 }
    twenty_forties { 1 }
    two_point_field_goals { 1 }
    player { build(:player) }
    roster { build(:roster) }
    team { build(:team) }
  end
end