require 'rails_helper'

RSpec.describe Processors::Json::FantasyPlayer do
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

  let(:existing_team) { create(:team, nrl_id: 500028) }
  let(:non_existing_team_nrl_id) { 999999 }
  let(:player_processor) { described_class.new }

  before do
    existing_team
  end

  it "initializes correctly" do
    expect(player_processor.instance_variable_get(:@attrs_block)).to eq({})
  end


  it "skip is true if the player has been ingested already" do
    player_processor.set_attrs(attrs: example_json_block)
    player_processor.create
    expect(player_processor.skip?).to be_truthy
  end

  it "creates a player with the correct attributes if it does not exist" do
    player_processor.set_attrs(attrs: example_json_block.merge('id' => non_existing_team_nrl_id))
    expect { player_processor.create }.to change { Player.count }.by(1)
  end

  it "sets attributes correctly" do
    player_processor.set_attrs(attrs: example_json_block)
    expect(player_processor.instance_variable_get(:@attrs_block)[:name]).to eq("Nicholas Hynes")
    expect(player_processor.instance_variable_get(:@attrs_block)[:cost]).to eq(1000000)
    expect(player_processor.instance_variable_get(:@attrs_block)[:fantasy_points_average]).to eq(73.9)
  end

  it "correctly finds or initializes the team based on nrl_id" do
    player_processor.set_attrs(attrs: example_json_block)
    expect(player_processor.send(:team)).to eq(existing_team)

    player_processor.set_attrs(attrs: example_json_block.merge('squad_id' => non_existing_team_nrl_id))
    expect(player_processor.send(:team)).to be_nil
  end
end
