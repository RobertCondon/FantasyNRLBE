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
#  home_roster_id :integer
#  winner_id      :bigint
#
FactoryBot.define do
  factory :match do
    date { "2020-01-01 00:00:00" }
    round { 1 }
    score { "30-0" }
    away_roster { create(:roster) }
    home_roster { create(:roster) }
    winner { build(:team) }
  end
end
