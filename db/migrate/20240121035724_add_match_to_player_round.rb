class AddMatchToPlayerRound < ActiveRecord::Migration[7.0]
  def up
    add_reference :player_rounds, :match, foreign_key: true
  end

  def down
    remove_reference :player_rounds, :match, foreign_key: true
  end
end
