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
#  nrl_id          :integer
#
require 'rails_helper'

RSpec.describe Team, type: :model do
  it { should have_many(:players) }
  it { should have_many(:rosters) }

  it "should have a valid factory" do
    expect(build(:team)).to be_valid
  end

  describe '#matches' do
    let(:team) { create(:team) }
    let(:home_match) { create(:match, home_team: team) }
    let(:away_match) { create(:match, away_team: team) }

    it 'returns matches where the team is either home or away' do
      expect(team.matches).to include(home_match, away_match)
    end

    it 'does not return matches where the team is not involved' do
      unrelated_match = create(:match)
      expect(team.matches).not_to include(unrelated_match)
    end

    it 'runs populate_from_fantasy correctly' do
      teams_json = {}
      team_processor = {}
      expect(Fetchers::NrlFantasy).to receive(:json).with("ladder").and_return(teams_json)
      expect(Processors::Json::FantasyTeam).to receive(:new).and_return(team_processor)
      expect(Importers::Interface).to receive(:import).with(data: teams_json, processor: team_processor)
      Team.populate_from_fantasy
    end
  end
end
