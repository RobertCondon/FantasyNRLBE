module Processors
  module Json
    class NrlMatch
      attr :away_team, :home_team, :winner_team, :attrs_block
      def initialize
        @attrs_block = {}
      end

      def create
        ::Match.create!({
          away_team_id: away_team.id,
          home_team_id: home_team.id,
          winner_id: winner_team.id,
        }.merge(attrs_block))
      end

      def skip?
        ::Match.find_by(score: attrs_block[:score], date: attrs_block[:date], winner_id: winner_team.id).present?
      end

      def set_attrs(attrs:)
        attrs_block[:year] = attrs["clock"]["kickOffTimeLong"].split("-").first
        attrs_block[:date] = attrs["clock"]["kickOffTimeLong"]
        attrs_block[:round] = attrs['roundTitle'].split(" ").last
        home_score = attrs['homeTeam']['score']
        away_score = attrs['awayTeam']['score']
        attrs_block[:score] = "#{home_score}-#{away_score}"

        if home_score > away_score
          @winner_team = find_team(attrs['homeTeam']['teamId'])
        else
          @winner_team = find_team(attrs['awayTeam']['teamId'])
        end

        @away_team = find_team(attrs['awayTeam']['teamId'])
        @home_team = find_team(attrs['homeTeam']['teamId'])
      end

      private

      def find_team(nrl_id)
        Team.find_by(nrl_id: nrl_id)
      end
    end
  end
end