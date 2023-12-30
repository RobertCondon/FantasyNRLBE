class RemoveWinnerColumn < ActiveRecord::Migration[7.0]
  def up
    remove_column :matches, :winner_id if column_exists?(:matches, :winner_id)
  end

  def down
    add_column :matches, :winner_id, :integer unless column_exists?(:matches, :winner_id)
  end
end
