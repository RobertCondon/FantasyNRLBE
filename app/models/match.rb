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
  belongs_to :winner, class_name: 'Team', foreign_key: :winner_id, optional: true
  belongs_to :home_team, class_name: 'Team', foreign_key: :home_team_id
  belongs_to :away_team, class_name: 'Team', foreign_key: :away_team_id

  def self.populate_current_player_positions_for_match(matches:)
    matches.each do |match|
      players_blob = Fetchers::Update::NrlMatchStats.new(match: match)
      player_processor = Processors::Json::Update::FantasyPlayerCurrentPosition.new
      return "no team list for match yet" if players_blob.home_team_stats.nil? || players_blob.away_team_stats.nil?

      Importers::Interface.import(data: players_blob.home_team_stats, processor: player_processor)
      Importers::Interface.import(data: players_blob.away_team_stats, processor: player_processor)
      PlayerRoundsFromDb.populate_rounds(match: match)
    end
  end

  private

  def self.populate_from_fantasy(round:, year:)
    years = [year].flatten
    rounds = [round].flatten
    match_processor = Processors::Json::NrlMatch.new

    years.each do |year|
      rounds.each do |round|
        players_blob = Fetchers::NrlMatches.json(round: round, year: year)
        Importers::Interface.import(data: players_blob, processor: match_processor)
      end
    end
  end
end
