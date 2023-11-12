module Parsers
  class Ladder
    attr :rows
    def initialize(rows)
      @rows = rows
    end

    def parse
      rows.each do |row|
        columns = row.find_elements(:css, "td")
        position = columns[0].find_elements(:css, "span")[0].text.strip
        name = row.find_elements(:css, ".ladder__item--club-header .ladder-club")[0].text.strip
        team = Team.find_or_create_by({ name: name })
        team.update(ladder_position: position.to_i)
      end
      nil
    end
  end
end