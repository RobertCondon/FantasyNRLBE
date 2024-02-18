module Api
  class MatchesController < ApplicationController
    before_action :set_match, only: %i[show update destroy]

    def index
      @matches = Querier.call(params, Match)
      render json: @matches
    end

    def show
      render json: @match
    end

    def create
      @match = Match.new(match_params)
      if @match.save
        render json: @match, status: :created
      else
        render json: @match.errors, status: :unprocessable_entity
      end
    end

    def update
      if @match.update(match_params)
        render json: @match
      else
        render json: @match.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @match.destroy
      head :no_content
    end

    private

    def set_match
      @match = Match.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Match not found' }, status: :not_found unless @match
    end

    def match_params
      params.permit(:date, :round, :score, :year, :away_team_id, :home_team_id, :winner_id)
    end
  end
end
