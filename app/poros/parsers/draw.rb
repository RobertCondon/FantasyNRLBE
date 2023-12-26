module Parsers
  class Draw
    attr :matches, :round
    def initialize(matches, round)
      @matches = matches
      @round = round
    end

    def parse
      matches.each do |match|
        Processors::Match.process(match, round)
      end
    end
  end
end