# == Schema Information
#
# Table name: players
#
#  id                     :bigint           not null, primary key
#  cost                   :integer
#  current_position       :string
#  fantasy_points_average :decimal(, )
#  fantasy_points_total   :integer
#  name                   :string
#  owned_by               :decimal(, )
#  position               :string
#  price                  :integer
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
end
