class AddWinnerColumnToMatch < ActiveRecord::Migration[7.0]
  def change
    add_column :matches, :winner_id, :bigint
  end
end
