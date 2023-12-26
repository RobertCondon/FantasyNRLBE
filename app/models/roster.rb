# == Schema Information
#
# Table name: rosters
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  player_id  :integer
#  team_id    :bigint
#
class Roster < ApplicationRecord
  belongs_to :team
  belongs_to :player
  has_one :away_match, class_name: 'Match', foreign_key: 'away_roster_id'
  has_one :home_match, class_name: 'Match', foreign_key: 'home_roster_id'

  scope :with_match, ->(match) {
    where(id: [match.away_roster_id, match.home_roster_id])
  }

  def match
    away_match || home_match
  end
end
