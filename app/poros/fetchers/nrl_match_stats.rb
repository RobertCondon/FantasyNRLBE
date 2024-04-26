module Fetchers
  class NrlMatchStats
    attr :url, :raw_data, :json_data, :match

    def initialize(match:)
      @url = build_url(match)
      @match = match
      get_data
      return unless raw_data
      transform_data_to_json
    rescue StandardError
      return nil
    end

    def home_team_stats
      return [] unless player_stats&.dig('homeTeam')

      player_stats&.dig('homeTeam').map do |player|
        base_player_attrs = home_team_players[player['playerId'].to_i] || {}
        player.merge(base_player_attrs)
      end
    end

    def away_team_stats
      return [] unless player_stats&.dig('awayTeam')

      player_stats&.dig('awayTeam').map do |player|
        base_player_attrs = away_team_players[player['playerId'].to_i] || {}
        player.merge(base_player_attrs)
      end
    end

    def player_stats
      json_data&.dig('match', 'stats', 'players')
    end

    private

    def get_data
      @raw_data = RestClient.get(url).body
    rescue StandardError => e
      match.destroy
    end


    def home_team_players
      @home_team_players ||= home_team_player_blob.each_with_object({}) do |player, hash|
        player_id = player.delete("playerId")
        hash[player_id.to_i] = player
      end
    end

    def away_team_players
      @away_team_players ||= away_team_player_blob.each_with_object({}) do |player, hash|
        player_id = player.delete("playerId")
        hash[player_id] = player
      end
    end
    def home_team_player_blob
      json_data&.dig('match', 'homeTeam', 'players')
    end

    def away_team_player_blob
      json_data&.dig('match', 'awayTeam', 'players')
    end


    def transform_data_to_json
      data = raw_data.partition("\" q-data=\"")[2]
      data = data.partition("\" q-r-data=")[0]
      data = data.gsub('&quot;', '"')
      @json_data = JSON.parse(data)
    end

    def build_url(match)
      @url = "https://www.nrl.com/draw/nrl-premiership/#{match.year}/round-#{match.round}/#{match.home_team.url_name}-v-#{match.away_team.url_name}/"
    end
  end
end
