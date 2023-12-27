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
  has_many :rosters
  has_many :won_matches, class_name: 'Match', foreign_key: :winner_id

  def matches
    Match.where(home_roster_id: rosters.select(:id))
         .or(Match.where(away_roster_id: rosters.select(:id)))
  end
end
