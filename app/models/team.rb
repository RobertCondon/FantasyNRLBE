# == Schema Information
#
# Table name: teams
#
#  id              :bigint           not null, primary key
#  ladder_position :integer
#  name            :string
#  short_name      :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  nrl_id          :integer
#
class Team < ApplicationRecord
  has_many :players
  has_many :player_rounds
  # has_many :won_matches, class_name: 'Match', foreign_key: :winner_id

  def url_name
    name.downcase.gsub(" ", "-")
  end

  def matches
    Match.where(home_team_id: id)
         .or(Match.where(away_team_id: id))
  end

  def self.populate_from_fantasy
    teams_json = Fetchers::NrlFantasy.json("ladder")
    team_processor = Processors::Json::FantasyTeam.new
    Importers::Interface.import(data: teams_json, processor: team_processor)
  end
end
