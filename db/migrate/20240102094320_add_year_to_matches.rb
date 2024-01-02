class AddYearToMatches < ActiveRecord::Migration[7.0]
  def up
    add_column :matches, :year, :integer unless column_exists?(:matches, :year)
    add_index :matches, :year unless index_exists?(:matches, :year)
  end

  def down
    remove_column :matches, :year if column_exists?(:matches, :year)
    remove_index :matches, :year if index_exists?(:matches, :year)
  end
end
