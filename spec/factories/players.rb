# == Schema Information
#
# Table name: players
#
#  id         :bigint           not null, primary key
#  name       :string
#  position   :string
#  price      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :integer
#
FactoryBot.define do
  factory :player do
    name { "Lewis" }
    position { "Brown" }
    price { 1 }
    team { build(:team) }
  end
end
