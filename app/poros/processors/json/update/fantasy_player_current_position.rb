module Processors
  module Json
    module Update
      class FantasyPlayerCurrentPosition
        attr :team, :attrs_block, :player, :update_position, :force_update_img
        def initialize(update_position: true, force_update_img: false)
          @attrs_block = {}
          @player = nil
          @update_position = update_position
          @force_update_img = force_update_img
        end

        def create
          player.update(attrs_block)
          @attrs_block = {}
        end

        def skip?
          player.nil?
        end

        def set_attrs(attrs:)
          @player = Player.find_by(nrl_id: attrs['playerId'])
          attrs_block[:current_position] = attrs['position'] if update_position
          attrs_block[:image_url] = handle_image(attrs["headImage"]&.split("/remote.axd?")[1])
        end

        def handle_image(img_url)
          return if player.image_url.present? && !force_update_img
          return if image_doesnt_exist(img_url)

          attrs_block[:image_url] = img_url
        end

        def image_doesnt_exist(image_url)
          RestClient.get(image_url).code == 404
        rescue RestClient::Forbidden
          true
        rescue RestClient::NotFound
          true
        rescue RestClient::Unauthorized
          true
        rescue RestClient::BadRequest
          true
        rescue RestClient::Exceptions::OpenTimeout
          true
        rescue ArgumentError
          true
        rescue
          true
        end
      end
    end
  end
end
