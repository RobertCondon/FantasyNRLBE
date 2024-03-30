class BackfillDb
  def initialize(from_year = 2019, current_round = 4)
    @from_year = from_year
    @current_round = current_round
  end

  def backfill
    Team.populate_from_fantasy
    Player.populate_from_fantasy
    matches
    PlayerRound.populate_from_fantasy(matches: Match.where(year: (@from_year..Time.now.year).to_a))
    PlayerRound.update_from_fantasy(matches: Match.where(year: Time.now.year, round: @current_round))
  end

  def matches
    rounds = (1..26).to_a
    current_rounds = (1..@current_round).to_a
    current_year = Time.now.year
    years = (@from_year..(current_year-1)).to_a
    Match.populate_from_fantasy(round: rounds, year: years)
    Match.populate_from_fantasy(round: current_rounds, year: [current_year])
  end
end
