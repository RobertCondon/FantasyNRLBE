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

  it "should have a valid factory" do
    expect(build(:team)).to be_valid
  end

  describe '#matches' do
    let(:team) { create(:team) }
    let(:roster) { create(:roster, team: team) }
    let(:home_match) { create(:match, home_roster: roster) }
    let(:away_match) { create(:match, away_roster: roster) }

    it 'returns matches where the team is either home or away' do
      expect(team.matches).to include(home_match, away_match)
    end

    it 'does not return matches where the team is not involved' do
      unrelated_match = create(:match)
      expect(team.matches).not_to include(unrelated_match)
    end
  end

end
