module Parsers
  class Draw
    attr :matches, :round
    def initialize(matches, round)
      @matches = matches
      @round = round
    end

    def parse
      matches.each do |match|
        string_date = match.find_elements(:css, ".match-header__title")[0].text.strip
        date = Time.parse(string_date)
        p date


        home_team_name = match.find_elements(:css, ".match-team__name--home")[0].text.strip
        home_team_score = match.find_elements(:css, ".match-team__score--home")[0].text.strip.delete("^0-9")
        p home_team_name
        p home_team_score

        away_team_name = match.find_elements(:css, ".match-team__name--away")[0].text.strip
        away_team_score = match.find_elements(:css, ".match-team__score--away")[0].text.strip.delete("^0-9")
        p away_team_name
        p away_team_score


        home_team = Team.find_by(name: home_team_name)
        away_team = Team.find_by(name: away_team_name)

        winner = home_team_score > away_team_score ? home_team : away_team


        match = Match.find_or_create_by(
          {
            date: date,
            round: round,
            away_team: away_team,
            home_team: home_team,
            winner: winner,
            score: "#{home_team_score} - #{away_team_score}"
          })
      end
      nil
    end
  end
end