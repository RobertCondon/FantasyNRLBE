module Processors
  module Json
    class FantasyPlayer
      attr :team, :attrs_block
      def initialize
        @attrs_block = {}
      end

      def create
        Player.create!({
          team: team,
        }.merge(attrs_block))
      end

      def skip?
        Player.find_by(nrl_id: attrs_block[:nrl_id]).present?
      end

      def set_attrs(attrs:)
        stats = attrs['stats']
        attrs_block[:name] = "#{attrs['first_name']} #{attrs['last_name']}"
        attrs_block[:position] = Player.position_from_fantasy(attrs['positions']) if attrs['positions']
        attrs_block[:nrl_id] = attrs['id']
        attrs_block[:cost] = attrs['cost']
        attrs_block[:status] = attrs['status']
        attrs_block[:current_position] = attrs['status'] unless attrs['status'].nil? || attrs['status'] == "playing"
        attrs_block[:owned_by] = stats['owned_by']
        attrs_block[:fantasy_points_total] = stats['total_points']
        attrs_block[:fantasy_points_average] = stats['avg_points']
        set_team(attrs['squad_id'])
      end

      private

      def set_team(nrl_id)
        @team = Team.find_by(nrl_id: nrl_id)
      end
    end
  end
end
