class AddCurrentImageUrlColumnToPlayer < ActiveRecord::Migration[7.0]
  def up
    add_column :players, :image_url, :string unless column_exists? :players, :image_url
  end

  def down
    remove_column :players, :image_url if column_exists? :players, :image_url
  end
end
