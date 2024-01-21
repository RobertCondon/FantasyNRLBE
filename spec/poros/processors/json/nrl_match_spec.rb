require 'rails_helper'

RSpec.describe Processors::Json::NrlMatch do
  let(:example_json_block) {
    JSON.parse(
      {
        "roundTitle": "Round 1",
        "homeTeam": {
          "teamId": 500001,
          "score": 32
        },
        "awayTeam": {
          "teamId": 500031,
          "score": 14
        },
        "clock": {
          "kickOffTimeLong": "2003-03-14T00:00:00Z"
        }
      }.to_json
    )
  }

  before do
    create(:team, nrl_id: 500001) # Assuming 'team' factory is defined for Team model
    create(:team, nrl_id: 500031)
  end

  it "creates a match with the correct attributes" do
    match_processor = described_class.new
    match_processor.set_attrs(attrs: example_json_block)
    expect { match_processor.create }.to change(::Match, :count).by(1)

    match = ::Match.last
    expect(match.year).to eq(2003)
    expect(match.date).to eq("2003-03-14T00:00:00Z")
    expect(match.round).to eq(1)
    expect(match.score).to eq("32-14")
    expect(match.home_team_id).to eq(Team.find_by(nrl_id: 500001).id)
    expect(match.away_team_id).to eq(Team.find_by(nrl_id: 500031).id)
    expect(match.winner_id).to eq(Team.find_by(nrl_id: 500001).id)
  end

  it "skip is true when the match already exists" do
    home_team = Team.find_by(nrl_id: 500001)
    away_team = Team.find_by(nrl_id: 500031)
    create(:match, score: "32-14", date: "2003-03-14T00:00:00Z", winner_id: home_team.id)

    match_processor = described_class.new
    match_processor.set_attrs(attrs: example_json_block)
    expect(match_processor.skip?).to eq(true)
  end
end
