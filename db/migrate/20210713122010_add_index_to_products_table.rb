class AddIndexToProductsTable < ActiveRecord::Migration[6.1]
  def change
    add_index :products, :id
  end
end
