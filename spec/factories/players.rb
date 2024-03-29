# == Schema Information
#
# Table name: players
#
#  id                     :bigint           not null, primary key
#  cost                   :integer
#  current_position       :string
#  fantasy_points_average :decimal(, )
#  fantasy_points_total   :integer
#  image_url              :string
#  name                   :string
#  owned_by               :decimal(, )
#  position               :string
#  price                  :integer
#  price_change           :integer
#  status                 :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  nrl_id                 :integer
#  team_id                :integer
#
FactoryBot.define do
  factory :player do
    name { "Lewis" }
    position { "Brown" }
    price { 1 }
    team { build(:team) }
  end
end
