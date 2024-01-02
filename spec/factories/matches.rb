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
FactoryBot.define do
  factory :match do
    date { "2020-01-01 00:00:00" }
    round { 1 }
    score { "30-0" }
    away_roster { create(:roster) }
    home_roster { create(:roster) }
    winner { build(:team) }
    home_team { build(:team) }
    away_team { build(:team) }
  end
end
