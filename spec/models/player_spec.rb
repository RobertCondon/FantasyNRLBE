# == Schema Information
#
# Table name: players
#
#  id                     :bigint           not null, primary key
#  cost                   :integer
#  fantasy_points_average :decimal(, )
#  fantasy_points_total   :integer
#  name                   :string
#  owned_by               :decimal(, )
#  position               :string
#  price                  :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  nrl_id                 :integer
#  team_id                :integer
#
require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should belong_to(:team) }

  it "should have a valid factory" do
    expect(build(:player)).to be_valid
  end
end
