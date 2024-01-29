require 'rails_helper'

RSpec.describe Fetchers::NrlMatchStats do
  let(:player_stat_keys) do
    %w[playerId allRunMetres allRuns bombKicks crossFieldKicks conversions conversionAttempts dummyHalfRuns dummyHalfRunMetres dummyPasses errors fantasyPointsTotal fieldGoals forcedDropOutKicks fortyTwentyKicks goals goalConversionRate grubberKicks handlingErrors hitUps hitUpRunMetres ineffectiveTackles intercepts kicks kicksDead kicksDefused kickMetres kickReturnMetres lineBreakAssists lineBreaks lineEngagedRuns minutesPlayed missedTackles offloads offsideWithinTenMetres oneOnOneLost oneOnOneSteal onePointFieldGoals onReport passesToRunRatio passes playTheBallTotal playTheBallAverageSpeed penalties points penaltyGoals postContactMetres receipts ruckInfringements sendOffs sinBins stintOne tackleBreaks tackleEfficiency tacklesMade tries tryAssists twentyFortyKicks twoPointFieldGoals]
  end
  let(:tigers) { create(:team, name: "Wests Tigers") }
  let(:storm) { create(:team, name: "Storm") }
  let(:match) { create(:match, year: 2022, round: 1, home_team: tigers, away_team: storm) }

  let(:subject) do
    VCR.use_cassette("nrl_match_stats") do
      Fetchers::NrlMatchStats.new(match: match)
    end
  end

  it "should have a url" do
    expect(subject.url).to eq("https://www.nrl.com/draw/nrl-premiership/2022/round-1/wests-tigers-v-storm/")
  end

  it "should have raw_data" do
    expect(subject.raw_data).to be_a(String)
  end

  it "should have json_data" do
    expect(subject.json_data).to be_a(Hash)
  end

  context "player_stats" do
    it "should have home and away team stats" do
      expect(subject.home_team_stats).to be_a(Array)
      expect(subject.away_team_stats).to be_a(Array)
    end

    it "home and away team stats should be of correct length" do
      expect(subject.home_team_stats.length).to eq(18)
      expect(subject.away_team_stats.length).to eq(18)
    end

    it "home and away team stats should have correct keys" do
      subject.home_team_stats.each do |player|
        expect(player.keys).to include(*player_stat_keys)
      end

      subject.away_team_stats.each do |player|
        expect(player.keys).to include(*player_stat_keys)
      end
    end
  end

end
