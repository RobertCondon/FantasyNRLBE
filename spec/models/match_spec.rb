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
#  away_team_id   :integer
#  home_roster_id :integer
#  home_team_id   :integer
#  winner_id      :bigint
#
# Indexes
#
#  index_matches_on_away_roster_id  (away_roster_id)
#  index_matches_on_away_team_id    (away_team_id)
#  index_matches_on_home_roster_id  (home_roster_id)
#  index_matches_on_home_team_id    (home_team_id)
#
require 'rails_helper'

RSpec.describe Match, type: :model do
  it { should belong_to(:away_roster).class_name('Roster').with_foreign_key('away_roster_id') }
  it { should belong_to(:home_roster).class_name('Roster').with_foreign_key('home_roster_id') }
  it { should belong_to(:winner).class_name('Team').with_foreign_key('winner_id') }

  it "should have a valid factory" do
    expect(build(:match)).to be_valid
  end

  describe 'validations' do
    it 'does not allow home and away rosters to be the same' do
      roster = create(:roster)
      match = build(:match, home_roster: roster, away_roster: roster)

      expect(match).not_to be_valid
      expect(match.errors[:away_roster_id]).to include('cannot be the same as home roster')
    end
  end
end
