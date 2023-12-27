module Fetchers
  class NrlFantasy

    def initialize(type)
      @url = "https://fantasy.nrl.com/data/nrl/#{type}.json"
    end

    def self.json(type)
      new(type).json
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
