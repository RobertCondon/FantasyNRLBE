module Api
  class BackfillController < ApplicationController

    def create
      backfiller = BackfillDb.new
      backfiller.backfill
      render json: { message: 'Backfill complete' }
    end

  end
end
