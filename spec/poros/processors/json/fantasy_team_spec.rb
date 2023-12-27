require 'rails_helper'

RSpec.describe Processors::Json::FantasyTeam do
  let(:example_json_block) {
    JSON.parse(
      {
        "id": 500011,
        "full_name": "Brisbane Broncos",
        "name": "Broncos",
        "short_name": "BRI",
        "games": 0,
        "win": 0,
        "loss": 0,
        "draw": 0,
        "points": 0,
        "margin": 0,
        "odds": "",
        "odds_id": "",
        "odds_top4": "",
        "odds_top8": ""
      }.to_json
    )
  }

  it "creates a player_round with the correct attrs" do
    expect(Team.count).to eq(0)
    described_class.create_team(attrs: example_json_block)
    expect(Team.count).to eq(1)
    team = Team.find_by(nrl_id: 500011)
    expect(team.name).to eq("Broncos")
    expect(team.short_name).to eq("BRI")
  end
end
