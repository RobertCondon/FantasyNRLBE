module Processors
  module Json
    module Update
      class FantasyPlayerCurrentPosition
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
          @player = Player.find_by(nrl_id: attrs['playerId'])
          attrs_block[:current_position] = attrs['position']
        end
      end
    end
  end
end
