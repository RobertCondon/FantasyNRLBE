# == Schema Information
#
# Table name: players
#
#  id                     :bigint           not null, primary key
#  cost                   :integer
#  current_position       :string
#  fantasy_points_average :decimal(, )
#  fantasy_points_total   :integer
#  image_url              :string
#  name                   :string
#  owned_by               :decimal(, )
#  position               :string
#  price                  :integer
#  price_change           :integer
#  status                 :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  nrl_id                 :integer
#  team_id                :integer
#
class Player < ApplicationRecord
  belongs_to :team

  def self.populate_from_fantasy
    players_blob = Fetchers::NrlFantasy.json("players")
    player_processor = Processors::Json::FantasyPlayer.new
    Importers::Interface.import(data: players_blob, processor: player_processor)
  end

  def self.update_from_fantasy
    players_blob = Fetchers::NrlFantasy.json("players")
    player_processor = Processors::Json::Update::FantasyPlayer.new
    Importers::Interface.import(data: players_blob, processor: player_processor)
  end

  def self.populate_player_images(matches:, force_update_img:)
    matches.each do |match|
      players_blob = Fetchers::Update::NrlMatchStats.new(match: match)
      player_processor = Processors::Json::Update::FantasyPlayerCurrentPosition.new(update_position: false, force_update_img: force_update_img)
      return "no team list for match yet" if players_blob.home_team_stats.nil? || players_blob.away_team_stats.nil?

      Importers::Interface.import(data: players_blob.home_team_stats, processor: player_processor)
      Importers::Interface.import(data: players_blob.away_team_stats, processor: player_processor)
    end
  end

  def self.position_from_fantasy(positions)
    positions.map { |num| fantasy_pos_to_s(num) }.join(' | ')
  end
  def self.fantasy_pos_to_s(position)
    case position.to_i
    when 1
      "HOK"
    when 2
      "MID"
    when 3
      "EDG"
    when 4
      "HLF"
    when 5
      "CTR"
    when 6
      'WFB'
    end
  end
end
