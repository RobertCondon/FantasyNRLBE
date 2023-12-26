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
require 'rails_helper'

RSpec.describe Roster, type: :model do
  it { should belong_to(:team) }
  it { should belong_to(:player) }
  it { should have_one(:away_match).class_name('Match').with_foreign_key('away_roster_id') }
  it { should have_one(:home_match).class_name('Match').with_foreign_key('home_roster_id') }

  it "should have a valid factory" do
    expect(build(:roster)).to be_valid
  end

  describe '.with_match' do
    let(:team1) { create(:team) }
    let(:team2) { create(:team) }
    let(:home_roster) { create(:roster, team: team1) }
    let(:away_roster) { create(:roster, team: team2) }
    let(:match) { create(:match, home_roster: home_roster, away_roster: away_roster) }

    it 'returns rosters associated with the given match' do
      expect(Roster.with_match(match)).to include(home_roster, away_roster)
    end

    it 'does not return rosters not associated with the given match' do
      other_roster = create(:roster)
      expect(Roster.with_match(match)).not_to include(other_roster)
    end
  end
end
