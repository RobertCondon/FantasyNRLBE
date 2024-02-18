module Api
  class PlayersController < ApplicationController
    before_action :set_player, only: %i[show update destroy]

    def index
      @players = Querier.call(params, Player)
      render json: @players
    end

    def show
      render json: @player
    end

    def create
      @player = Player.new(player_params)
      if @player.save
        render json: @player, status: :created
      else
        render json: @player.errors, status: :unprocessable_entity
      end
    end

    def update
      if @player.update(player_params)
        render json: @player
      else
        render json: @player.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @player.destroy
      head :no_content
    end

    private

    def set_player
      @player = Player.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Player not found' }, status: :not_found unless @player
    end

    def player_params
      params.permit(:name, :cost, :fantasy_points_average, :fantasy_points_total, :owned_by, :position, :price, :status, :nrl_id, :team_id)
    end
  end
end
