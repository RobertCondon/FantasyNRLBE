module Api
  class PlayerRoundsController < ApplicationController
    before_action :set_player_round, only: %i[show update destroy]

    def index
      @player_rounds = Querier.call(params, match_player_rounds).ordered_by_match_date_desc
      render json: @player_rounds,  include: [:match, :player]
    end

    def show
      render json: @player_round
    end

    def create
      matches = Match.where(year: Time.now.year, round: params[:round])
      created_matches = PlayerRound.populate_from_fantasy(matches: matches)
      render json: { message: 'Creation of player rounds complete', created_matches: created_matches }
    end

    def update
      matches = Match.where(year: Time.now.year, round: params[:round])
      updated_matches = PlayerRound.update_from_fantasy(matches: matches)
      render json: { message: 'Update of player rounds complete', updated_matches: updated_matches }
    end

    def destroy
      @player_round.destroy
      head :no_content
    end

    private

    def match_player_rounds
      year = params[:year]
      round = params[:round]
      player_rounds = PlayerRound.includes(:match, :player)

      player_rounds = player_rounds.where(matches: { year: year, round: round }) if year && round
      player_rounds = player_rounds.where.not(minutes_played: nil) if params[:played]

      return player_rounds.ordered_by_match_date_desc
    end

    def set_player_round
      @player_round = PlayerRound.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Player round not found' }, status: :not_found unless @player_round
    end

    def player_round_params
      params.permit(:all_run_meters, :all_runs, :average_play_the_ball_speed, :bomb_kicks, :conversion_attempts, :conversions, :cross_field_kicks, :dummy_half_run_meters, :dummy_half_runs, :dummy_passes, :fantasy_points_total, :field_goals, :forced_drop_out_kicks, :forty_twenties, :goal_conversion_rate, :goals, :grubber_kicks, :handling_errors, :hit_up_run_meters, :hit_ups, :ineffective_tackles, :inside_10_meters, :intercepts, :kick_meters, :kick_return_meters, :kicks, :kicks_dead, :kicks_defused, :line_break_assists, :line_breaks, :line_engaged_runs, :minutes_played, :missed_tackles, :number, :offloads, :offside_within_ten_meters, :on_report, :one_on_one_lost, :one_on_one_steal, :one_point_field_goals, :passes, :passes_to_run_ratio, :penalties, :penalty_goals, :play_the_ball, :play_the_ball_average_speed, :player_errors, :points, :position, :post_contact_meters, :receipts, :ruck_infringements, :send_offs, :sin_bins, :stint_one, :stint_two, :tackle_breaks, :tackle_efficiency, :tackles_made, :total_points, :tries, :try_assists, :twenty_forties, :two_point_field_goals, :match_id, :player_id, :team_id)
    end
  end
end
