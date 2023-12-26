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
require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should belong_to(:team) }

  it "should have a valid factory" do
    expect(build(:player)).to be_valid
  end
end
