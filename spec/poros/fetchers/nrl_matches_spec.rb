require 'rails_helper'

RSpec.describe Fetchers::NrlMatches do
  describe '.json' do
    let(:round) { 15 }
    let(:year) { 2016 }
    let(:fixture_keys) do
      %w[isCurrentRound roundTitle type matchState venue homeTeam awayTeam clock]
    end
    let(:match_keys) do
      %w[teamId nickName score theme]
    end
    let(:subject) do
      VCR.use_cassette("nrl_matches_round_#{round}_year_#{year}") do
        described_class.json(round: round, year: year)
      end
    end

    it "returns an array of fixtures" do
      expect(subject).to be_an(Array)
    end

    it "contains hashes with correct structure for each match" do
      expect(subject.first).to be_a(Hash)
      expect(subject.first.keys).to include(*fixture_keys)

      clock_keys = %w[kickOffTimeLong gameTime]

      subject.each do |match|
        expect(match["homeTeam"].keys).to include(*match_keys)
        expect(match["awayTeam"].keys).to include(*match_keys)
        expect(match["clock"].keys).to include(*clock_keys)
      end
    end

    it "has correct round and year information in each match" do
      subject.each do |match|
        expect(match["roundTitle"]).to include("Round #{round}")
        expect(match["clock"]["kickOffTimeLong"]).to include(year.to_s)
      end
    end
  end
end
