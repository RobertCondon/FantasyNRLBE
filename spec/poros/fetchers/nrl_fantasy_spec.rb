require 'rails_helper'

RSpec.describe Fetchers::NrlFantasy do

  let(:player_keys) do
    %w[id first_name last_name cost status]
  end

  let(:player_stat_keys) do
    %w[total_points avg_points owned_by]
  end

  let(:subject) do
    VCR.use_cassette("nrl_fantasy_players") do
      described_class.json("player")
    end
  end

  it "should be a array" do
    expect(subject).to be_a(Array)
  end

  it "should have 481 players" do
    expect(subject.length).to eq(481)
  end

  it "should contain hashes of players in the array with the correct keys" do
    expect(subject.first).to be_a(Hash)
    subject.each do |player|
      expect(player.keys).to include(*player_keys)
      expect(player['stats'].keys).to include(*player_stat_keys)
    end
  end
end
