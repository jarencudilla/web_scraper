json.extract! product, :id, :item_name, :item_image, :item_rating, :price, :store, :item_description, :item_brand, :item_model, :sku, :display_size, :Processor_type, :model, :warranty, :created_at, :updated_at
json.url product_url(product, format: :json)
