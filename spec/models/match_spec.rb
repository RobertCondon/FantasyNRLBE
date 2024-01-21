# == Schema Information
#
# Table name: matches
#
#  id           :bigint           not null, primary key
#  date         :datetime
#  round        :integer
#  score        :string
#  year         :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  away_team_id :integer
#  home_team_id :integer
#  winner_id    :integer
#
# Indexes
#
#  index_matches_on_away_team_id  (away_team_id)
#  index_matches_on_home_team_id  (home_team_id)
#  index_matches_on_year          (year)
#
require 'rails_helper'

RSpec.describe Match, type: :model do
  it { should belong_to(:winner).class_name('Team').with_foreign_key('winner_id') }
  it { should belong_to(:home_team).class_name('Team').with_foreign_key('home_team_id') }
  it { should belong_to(:away_team).class_name('Team').with_foreign_key('away_team_id') }

  it "should have a valid factory" do
    expect(build(:match)).to be_valid
  end
end
