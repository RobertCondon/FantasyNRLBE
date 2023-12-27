module Processors
  module Json
    class FantasyTeam
      def self.create_team(attrs:)
        new.create_team(attrs: attrs)
      end

      def create_team(attrs:)
        process_attrs(attrs)
        Team.create!(attrs_block)
      end

      private

      attr :attrs_block

      def initialize
        @attrs_block = {}
      end

      def process_attrs(attrs)
        attrs_block[:name] = attrs['name']
        attrs_block[:short_name] = attrs['short_name']
        attrs_block[:nrl_id] = attrs['id']
      end
    end
  end
end
