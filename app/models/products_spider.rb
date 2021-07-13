# product spider

require 'open-uri'
require 'nokogiri'
require 'kimurai'

class ProductsSpider < Kimurai::Base
  @engine = :selenium_firefox
  @start_urls = ["https://pcpartpicker.com/"]

  def parse(response, url:, data: {})
    # Process request to `parse_product` method with `https://example.com/some_product` url:
    request_to :parse_product, url: "https://pcpartpicker.com/products/motherboard/"
  end

  def parse_product(response, url:, data: {})
    puts "From page https://pcpartpicker.com/products/motherboard/ !"
  end
end
