module Fetchers
  class NrlMatches
    def initialize(round:, year:)
      @url = "https://www.nrl.com/draw//data?competition=111&round=#{round}&season=#{year}&showOdds=true"
    end

    def self.json(round:, year:)
      new(round: round, year: year).fixtures
    end

    def fixtures
      jsonized_data["fixtures"]
    end

    private

    attr_reader :url

    def jsonized_data
      JSON.parse(data)
    end

    def data
      RestClient.get(url).body
    end
  end
end
