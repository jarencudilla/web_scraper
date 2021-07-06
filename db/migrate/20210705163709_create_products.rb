# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :item_name
      t.string :item_image
      t.string :item_rating
      t.integer :price
      t.string :store
      t.string :item_description
      t.string :item_brand
      t.string :item_model
      t.string :sku
      t.string :display_size
      t.string :Processor_type
      t.string :model
      t.integer :warranty

      t.timestamps
    end
  end
end
