module Processors
  module Json
    class FantasyPlayer
      attr :team, :attrs_block
      def initialize(team:)
        @team = team
        @attrs_block = {}
      end

      def create_player( attrs:)
        process_attrs(attrs) if attrs.present?

        Player.create!({
          team: team,
        }.merge(attrs_block))
      end

      private

      def process_attrs(attrs)
        stats = attrs['stats']
        attrs_block[:name] = "#{attrs['first_name']} #{attrs['last_name']}"
        attrs_block[:position] = attrs['position']
        attrs_block[:nrl_id] = attrs['id']
        attrs_block[:cost] = attrs['cost']
        attrs_block[:status] = attrs['status']
        attrs_block[:owned_by] = stats['owned_by']
        attrs_block[:fantasy_points_total] = stats['total_points']
        attrs_block[:fantasy_points_average] = stats['avg_points']
      end
    end
  end
end
