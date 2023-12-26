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
require 'rails_helper'

RSpec.describe Team, type: :model do
  it { should have_many(:players) }
  it { should have_many(:rosters) }
  it { should have_many(:won_matches).class_name('Match').with_foreign_key('winner_id') }
  it { should have_many(:matches).through(:rosters) }

  it "should have a valid factory" do
    expect(build(:team)).to be_valid
  end
end
