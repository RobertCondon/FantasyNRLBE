module Api
  class BackfillController < ApplicationController

    def create
      backfiller = BackfillDb.new(current_round: params[:current_round])
      backfiller.backfill
      render json: { message: 'Backfill complete' }
    end

    def destroy
      [Team, Player, PlayerRound, Match].each do |model|
        model.delete_all
      end

      render json: { message: 'DB Wiped' }
    end
  end
end
