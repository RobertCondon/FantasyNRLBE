module Api
  class BackfillController < ApplicationController

    def update
      matches = Match.where(year: Time.now.year, round: params[:round])
      Match.populate_current_player_positions_for_match(matches: matches)
      render json: { message: 'Update of current positions complete' }
    end

  end
end
