module Processors
  class Match
    attr :match, :round
    def initialize(match, round)
      @match = match
      @round = round
    end

    def self.process(match, round)
      new(match, round).process
    end

    def process
      string_date = match.find_elements(:css, ".match-header__title")[0].text.strip
      date = Time.parse(string_date)

      created_match = Match.find_or_create_by(
        {
          date: date,
          round: round,
          away_team: away_roster,
          home_roster: home_roster,
          winner: winner,
          score: "#{home_team_score} - #{away_team_score}"
        })
      p "created match!"
      p created_match
    end

    def home_team
      @home_team ||= fetch_team("home")
    end

    def away_team
      @away_team ||= fetch_team("away")
    end

    def away_roster
      @away_roster ||= Roster.create(team: home_team)
    end

    def home_roster
      @home_roster ||= Roster.create(team: away_team)
    end

    def winner
      did_home_team_win? ? home_team : away_team
    end

    def did_home_team_win?
      home_team_score > away_team_score
    end

    def fetch_team(side)
      team_name = match.find_elements(:css, ".match-team__name--#{side}")[0].text.strip
      Team.find_or_create_by(name: team_name)
    end

    def home_team_score
      @home_team_score ||= match.find_elements(:css, ".match-team__score--home")[0].text.strip.delete("^0-9")
    end

    def away_team_score
      @away_team_score ||= match.find_elements(:css, ".match-team__score--away")[0].text.strip.delete("^0-9")
    end
  end
end