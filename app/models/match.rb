# == Schema Information
#
# Table name: matches
#
#  id             :bigint           not null, primary key
#  date           :datetime
#  round          :integer
#  score          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  away_roster_id :integer
#  away_team_id   :integer
#  home_roster_id :integer
#  home_team_id   :integer
#  winner_id      :integer
#
# Indexes
#
#  index_matches_on_away_roster_id  (away_roster_id)
#  index_matches_on_away_team_id    (away_team_id)
#  index_matches_on_home_roster_id  (home_roster_id)
#  index_matches_on_home_team_id    (home_team_id)
#
class Match < ApplicationRecord
  belongs_to :away_roster, class_name: 'Roster', foreign_key: :away_roster_id
  belongs_to :home_roster, class_name: 'Roster', foreign_key: :home_roster_id
  belongs_to :winner, class_name: 'Team', foreign_key: :winner_id
  belongs_to :home_team, class_name: 'Team', foreign_key: :home_team_id
  belongs_to :away_team, class_name: 'Team', foreign_key: :away_team_id

  validate :home_and_away_rosters_must_be_different

  private

  def home_and_away_rosters_must_be_different
    if home_roster_id == away_roster_id
      errors.add(:away_roster_id, 'cannot be the same as home roster')
    end
  end
end
