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
#  price                       :integer
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
#  match_id                    :bigint
#  player_id                   :bigint
#  team_id                     :bigint
#
# Indexes
#
#  index_player_rounds_on_match_id  (match_id)
#
# Foreign Keys
#
#  fk_rails_...  (match_id => matches.id)
#
class PlayerRound < ApplicationRecord
  belongs_to :player
  belongs_to :team
  belongs_to :match

  scope :ordered_by_match_date_desc, -> {
    joins(:match).order('matches.date DESC')
  }


  def self.populate_from_fantasy(matches:)
    matches = [matches].flatten

    matches.each do |match|
      next if PlayerRound.where(match: match).count > 0
      players_blob = Fetchers::NrlMatchStats.new(match: match)
      next if players_blob.nil?

      home_player_processor = Processors::Json::PlayerRound.new(match: match, team: match.home_team)
      away_player_processor = Processors::Json::PlayerRound.new(match: match, team: match.away_team)
      Importers::Interface.import(data: players_blob.home_team_stats, processor: home_player_processor)
      Importers::Interface.import(data: players_blob.away_team_stats, processor: away_player_processor)
    end
  end

  def self.update_from_fantasy(matches:)
    matches.each do |match|
      next if PlayerRound.where(match: match).count == 0
      players_blob = Fetchers::NrlMatchStats.new(match: match)
      next if players_blob.nil?

      home_player_processor = Processors::Json::Update::PlayerRound.new(match: match, team: match.home_team)
      away_player_processor = Processors::Json::Update::PlayerRound.new(match: match, team: match.away_team)
      Importers::Interface.import(data: players_blob.home_team_stats, processor: home_player_processor)
      Importers::Interface.import(data: players_blob.away_team_stats, processor: away_player_processor)
    end
  end
end
