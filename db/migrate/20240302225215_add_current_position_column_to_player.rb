class AddCurrentPositionColumnToPlayer < ActiveRecord::Migration[7.0]
  def up
    add_column :players, :current_position, :string unless column_exists? :players, :current_position
  end

  def down
    remove_column :players, :current_position if column_exists? :players, :current_position
  end
end
