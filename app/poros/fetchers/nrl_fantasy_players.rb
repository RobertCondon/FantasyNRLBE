module Fetchers
  class NrlFantasyPlayers

    def initialize
      @url = "https://fantasy.nrl.com/data/nrl/players.json"
    end

    def self.json
      new.json
    end

    def json
      JSON.parse(data)
    end

    private

    attr_reader :url

    def data
      RestClient.get(url).body
    end
  end
end
