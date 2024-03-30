module Processors
  module Json
    module Update
      class FantasyPlayer
        attr :team, :attrs_block, :player
        def initialize
          @attrs_block = {}
          @player = nil
        end

        def create
          player.update(attrs_block)
        end

        def skip?
          player.nil?
        end

        def set_attrs(attrs:)
          stats = attrs['stats']
          set_team(attrs['squad_id'])
          @player = Player.find_by(nrl_id: attrs['id'])
          return if @player.nil?
          player_price_change = attrs['cost'] - @player.cost

          attrs_block[:name] = "#{attrs['first_name']} #{attrs['last_name']}"
          attrs_block[:position] = attrs['position']
          attrs_block[:nrl_id] = attrs['id']
          attrs_block[:cost] = attrs['cost']
          attrs_block[:price_change] = player_price_change unless player_price_change.zero?
          attrs_block[:status] = attrs['status']
          attrs_block[:owned_by] = stats['owned_by']
          attrs_block[:position] = position_array_to_string(attrs['positions'])
          attrs_block[:fantasy_points_total] = stats['total_points']
          attrs_block[:fantasy_points_average] = stats['avg_points']
          attrs_block[:team_id] = team.id
        end

        private

        def set_team(nrl_id)
          @team = Team.find_by(nrl_id: nrl_id)
        end

        def position_array_to_string(array)
          array.map { |num| position(num) }.join(' | ')
        end

        def position(num)
          case num
          when 1
            'HOK'
          when 2
            'MID'
          when 3
            'EDG'
          when 4
            'HLF'
          when 5
            'CTR'
          when 6
            'WFB'
          end
        end
      end
    end
  end
end
