module Processors
  module Json
    class FantasyTeam
      attr :attrs_block

      def initialize
        @attrs_block = {}
      end
      def set_attrs(attrs:)
        process_attrs(attrs)
      end

      def create
        Team.create!(attrs_block)
      end

      def skip?
        Team.find_by(nrl_id: attrs_block[:nrl_id]).present?
      end

      private

      def process_attrs(attrs)
        attrs_block[:name] = attrs['name']
        attrs_block[:short_name] = attrs['short_name']
        attrs_block[:nrl_id] = attrs['id']
      end
    end
  end
end
