require 'rails_helper'

RSpec.describe Processors::Json::FantasyPlayer do
  let(:team) { create(:team) }
  let(:example_json_block) {
    JSON.parse({
      "id": 502490,
      "first_name": "Nicholas",
      "last_name": "Hynes",
      "squad_id": 500028,
      "cost": 1000000,
      "status": "uncertain",
      "stats": {
        "prices": {
          "1": 1000000
        },
        "scores": {},
        "ranks": {},
        "season_rank": 0,
        "games_played": 20,
        "total_points": 1478,
        "avg_points": 73.9,
        "high_score": 98,
        "low_score": 34,
        "last_3_avg": 83,
        "last_5_avg": 71.2,
        "selections": 1667,
        "selections_info": {
          "c": 5.47,
          "vc": 4.59,
          "bc": 0.39,
          "res": 0.37
        },
        "owned_by": 15.55,
        "adp": 0,
        "proj_avg": 73.4,
        "wpr": 72.3266,
        "round_wpr": {
          "1": 72.3266
        },
        "rd_tog": "",
        "tog": 0,
        "career_avg": 73.9,
        "career_avg_vs": {
          "500001": 73,
          "500002": 72.5,
          "500003": 82,
          "500004": 64,
          "500005": 73,
          "500010": 80,
          "500011": 64,
          "500012": 92.5,
          "500013": 95,
          "500014": 34,
          "500021": 62,
          "500022": 96,
          "500023": 82,
          "500032": 65,
          "500723": 37
        },
        "last_3_proj_avg": 0
      },
      "positions": [
        4
      ],
      "original_positions": [],
      "original_squad_id": 0,
      "transfer_round": 0,
      "is_bye": 0,
      "locked": 0
    }.to_json)
  }

  it "initializes correctly" do
    player_round_processor = described_class.new(team: team)
    expect(player_round_processor.team).to eq(team)
    expect(player_round_processor.attrs_block).to eq({})
  end

  it "can create new player_rounds without any attrs" do
    player_round_processor = described_class.new(team: team)
    expect { player_round_processor.create_player(attrs: {}) }.to change { Player.count }.by(1)
  end

  it "can create new player_rounds with the correct attrs" do
    player_round_processor = described_class.new(team: team)
    expect(Player).to receive(:create!).with(hash_including(team: team))
    player_round_processor.create_player(attrs: example_json_block)
  end

  it "creates a player_round with the correct attrs" do
    described_class.new(team: team).create_player(attrs: example_json_block)
    player = Player.find_by(nrl_id: 502490)
    expect(player.name).to eq("Nicholas Hynes")
    expect(player.cost).to eq(1000000)
    expect(player.fantasy_points_average).to eq(73.9)
  end
end
