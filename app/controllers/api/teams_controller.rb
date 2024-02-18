module Api
  class TeamsController < ApplicationController
    before_action :set_team, only: %i[show update destroy matches]

    def index
      @teams = Querier.call(params, Team)
      render json: @teams
    end

    # GET /api/teams/1
    def show
      render json: @team
    end

    # POST /api/teams
    def create
      @team = Team.new(team_params)
      if @team.save
        render json: @team, status: :created, location: api_team_url(@team)
      else
        render json: @team.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/teams/1
    def update
      if @team.update(team_params)
        render json: @team
      else
        render json: @team.errors, status: :unprocessable_entity
      end
    end

    # DELETE /api/teams/1
    def destroy
      @team.destroy
      head :no_content
    end

    # GET /api/teams/1/matches
    def matches
      @matches = @team.matches
      render json: @matches
    end

    private

    def set_team
      @team = Team.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Team not found' }, status: :not_found unless @team
    end

    def team_params
      params.permit(:ladder_position, :name, :short_name, :nrl_id)
    end
  end
end
