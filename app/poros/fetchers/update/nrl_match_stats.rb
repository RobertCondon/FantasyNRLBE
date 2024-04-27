module Fetchers
  module Update
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
        player_stats&.dig('homeTeam', 'players')
      end

      def away_team_stats
        player_stats&.dig('awayTeam', 'players')
      end

      def player_stats
        json_data&.dig('match')
      end

      private

      def get_data
        @raw_data = RestClient.get(url).body
      rescue StandardError => e
        match.destroy
      end


      def transform_data_to_json
        data = raw_data.partition("\" q-data=\"")[2]
        data = data.partition("\" q-r-data='")[0]
        data = data.gsub('&quot;', '"')
        @json_data = JSON.parse(data)
      end

      def build_url(match)
        @url = "https://www.nrl.com/draw/nrl-premiership/#{match.year}/round-#{match.round}/#{match.home_team.url_name}-v-#{match.away_team.url_name}/"
      end
    end
  end
end
