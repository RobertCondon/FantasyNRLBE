class AddPriceIncreaseToPlayer < ActiveRecord::Migration[7.0]
  def up
    add_column :players, :price_change, :integer unless column_exists? :players, :price_change
  end

  def down
    remove_column :players, :price_change if column_exists? :players, :price_change
  end
end
