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
FactoryBot.define do
  factory :roster do
    team { build(:team) }
    player { build(:player) }
  end
end
