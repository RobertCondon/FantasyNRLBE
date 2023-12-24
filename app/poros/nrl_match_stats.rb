class NrlMatchStats
  attr :url, :raw_data, :json_data

  def initialize(year:, round:, home_team:, away_team:)
    @url = build_url(year, round, home_team, away_team)
    get_data
    transform_data_to_json
  end

  def home_team_stats
    player_stats['homeTeam']
  end

  def away_team_stats
    player_stats['awayTeam']
  end

  def player_stats
    json_data['match']['stats']['players']
  end

  private

  def get_data
    @raw_data = RestClient.get(url).body
  end


  def transform_data_to_json
    data = raw_data.partition("\" q-data=\"")[2]
    data = data.partition("\" q-r-data=")[0]
    data = data.gsub('&quot;', '"')
    @json_data = JSON.parse(data)
  end

  def build_url(year, round, home_team, away_team)
    @url = "https://www.nrl.com/draw/nrl-premiership/#{year}/round-#{round}/#{home_team}-v-#{away_team}/"
  end
end
