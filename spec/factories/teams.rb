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
#
FactoryBot.define do
  factory :team do
    ladder_position { 1 }
    name { "Warriors" }
    short_name { "WAR" }
  end
end
