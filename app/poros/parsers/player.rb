module Parsers
  class Player
    attr :player_cards, :names
    def initialize(player_cards)
      @player_cards = player_cards
      @names = []
    end

    def parse
      player_cards.each do |player_card|
        name_spans = player_card.find_elements(:css, ".card-themed-hero__name span")
        name = "#{name_spans[0].text.strip} #{name_spans[1].text.strip}"
        next if name == " " || names.include?(name)
        names.push(name)
        position = player_card.find_elements(:css, ".card-themed-hero__position")[0].text.strip
        team_name = player_card.find_elements(:css, ".card-themed-hero__team-name")[0].text.strip
        team = Team.find_by({ name: team_name })
        find_or_create_player(name, position, team)
      end
      nil
    end

    def find_or_create_player(name, position, team)
      Player.find_or_create_by!({name: name, team: team})
      Player.update!({position: position})
    end
  end
end