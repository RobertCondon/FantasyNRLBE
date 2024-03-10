class AddPriceToPlayerRound < ActiveRecord::Migration[7.0]
  def up
    add_column :player_rounds, :price, :integer unless column_exists? :player_rounds, :price
  end

  def down
    remove_column :player_rounds, :price if column_exists? :player_rounds, :price
  end
end
