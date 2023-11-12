class ChangeErrorsColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :player_rounds, :errors, :player_errors
  end
end
