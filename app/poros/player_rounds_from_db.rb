class PlayerRoundsFromDb
  attr :match, :attrs_block
  def initialize(match:)
    @match = match
    @attrs_block = {}
  end

  def parse_players_from_match
    match.home_team.players.each do |player|
      next if PlayerRound.where(player: player, team: player.team, match: match).present?
      parse_player(player)
    end
    match.away_team.players.each do |player|
      next if PlayerRound.where(player: player, team: player.team, match: match).present?
      parse_player(player)
    end
  end

  def self.populate_rounds(match:)
    self.new(match: match).parse_players_from_match
  end

  private

  def create_round(player, team, attrs_block = {})
    ::PlayerRound.create!({ player: player, team_id: team.id, match_id: match.id }.merge(attrs_block))
  end

  def parse_player(player)
    @attrs_block[:position] = player.current_position
    @attrs_block[:price] = player.price
    create_round(player, player.team, attrs_block)
  end
end

