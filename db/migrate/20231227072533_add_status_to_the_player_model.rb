class AddStatusToThePlayerModel < ActiveRecord::Migration[7.0]
  def up
    add_column :players, :status, :string unless column_exists?(:players, :status)
  end

  def down
    remove_column :players, :status if column_exists?(:players, :status)
  end
end
