require 'rails_helper'

RSpec.describe Processors::Json::PlayerRound do
  let(:team) { create(:team) }
  let(:player) { create(:player) }
  let(:match) { create(:match) }
  let(:example_json_block) {
    {
      "playerId"=>504098,
      "allRunMetres"=>109,
      "allRuns"=>11,
      "bombKicks"=>0,
      "crossFieldKicks"=>0,
      "conversions"=>0,
      "conversionAttempts"=>0,
      "dummyHalfRuns"=>3,
      "dummyHalfRunMetres"=>31,
      "dummyPasses"=>1,
      "errors"=>0,
      "fantasyPointsTotal"=>44,
      "fieldGoals"=>0,
      "forcedDropOutKicks"=>0,
      "fortyTwentyKicks"=>0,
      "goals"=>0,
      "goalConversionRate"=>0.0,
      "grubberKicks"=>2,
      "handlingErrors"=>0,
      "hitUps"=>0,
      "hitUpRunMetres"=>0,
      "ineffectiveTackles"=>0,
      "intercepts"=>0,
      "kicks"=>2,
      "kicksDead"=>1,
      "kicksDefused"=>0,
      "kickMetres"=>20,
      "kickReturnMetres"=>21,
      "lineBreakAssists"=>1,
      "lineBreaks"=>0,
      "lineEngagedRuns"=>0,
      "minutesPlayed"=>80,
      "missedTackles"=>0,
      "offloads"=>1,
      "offsideWithinTenMetres"=>0,
      "oneOnOneLost"=>0,
      "oneOnOneSteal"=>0,
      "onePointFieldGoals"=>0,
      "onReport"=>0,
      "passesToRunRatio"=>1.45,
      "passes"=>16,
      "playTheBallTotal"=>0,
      "playTheBallAverageSpeed"=>3.41,
      "penalties"=>1,
      "points"=>0,
      "penaltyGoals"=>0,
      "postContactMetres"=>19,
      "receipts"=>28,
      "ruckInfringements"=>0,
      "sendOffs"=>0,
      "sinBins"=>0,
      "stintOne"=>4800,
      "tackleBreaks"=>4,
      "tackleEfficiency"=>100.0,
      "tacklesMade"=>7,
      "tries"=>0,
      "tryAssists"=>2,
      "twentyFortyKicks"=>0,
      "twoPointFieldGoals"=>0
    }
  }

  it "initializes correctly" do
    player_round_processor = described_class.new(team: team, match: match)
    expect(player_round_processor.team).to eq(team)
    expect(player_round_processor.match).to eq(match)
    expect(player_round_processor.attrs_block).to eq({})
  end

  it "can create new player_rounds without any attrs" do
    player_round_processor = described_class.new(team: team, match: match)
    expect { player_round_processor.create_player_round(player: player, attrs: {}) }.to change { PlayerRound.count }.by(1)
  end

  it "can create new player_rounds with the correct attrs" do
    player_round_processor = described_class.new(team: team, match: match)
    expect(::PlayerRound).to receive(:create!).with(hash_including(player: player, team: team, match: match))
    player_round_processor.create_player_round(player: player, attrs: example_json_block)
  end

  it "creates a player_round with the correct attrs" do
    described_class.new(team: team, match: match).create_player_round(player: player, attrs: example_json_block)
    player_round = PlayerRound.find_by(player: player, team: team, match: match)
    expect(player_round).to be_a(::PlayerRound)
    expect(player_round.tackles_made).to eq(7)
    expect(player_round.play_the_ball_average_speed).to eq(3.41)
  end
end
