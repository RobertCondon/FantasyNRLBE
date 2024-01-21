# == Schema Information
#
# Table name: matches
#
#  id           :bigint           not null, primary key
#  date         :datetime
#  round        :integer
#  score        :string
#  year         :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  away_team_id :integer
#  home_team_id :integer
#  winner_id    :integer
#
# Indexes
#
#  index_matches_on_away_team_id  (away_team_id)
#  index_matches_on_home_team_id  (home_team_id)
#  index_matches_on_year          (year)
#
class Match < ApplicationRecord
  belongs_to :winner, class_name: 'Team', foreign_key: :winner_id
  belongs_to :home_team, class_name: 'Team', foreign_key: :home_team_id
  belongs_to :away_team, class_name: 'Team', foreign_key: :away_team_id


  private

  def self.populate_from_fantasy(round:, year:)
    players_blob = Fetchers::NrlMatches.json(round: round, year: year)
    player_processor = Processors::Json::NrlMatch.new
    Importers::Interface.import(data: players_blob, processor: player_processor)
  end
end
