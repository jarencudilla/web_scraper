# product spider

require 'kimurai'
require 'kimurai/all'

class ProductsSpider < Kimurai::Base
  @name = 'products_spider'
  @engine = @driver
  @start_urls = ['https://pcpartpicker.com/products/motherboard/']

  def parse(response, url:, data: {})
    response.xpath("//*[@id='products']/section/div/div[2]/section/div/div[2]").each do |a|
      request_to :parse_repo_page, url: absolute_url(a[:href], base: url)
    end

    if next_page = response.at_xpath("//*[@id="page_button_row_bot"]")
      request_to :parse, url: absolute_url(next_page[:href], base: url)
    end
  end

  def parse_repo_page(response, url:, data: {})
    item = {}

    item[:item_name] = response.xpath("//*[@id='category_content']/tr[2]/td[2]").text
    item[:item_description] = response.xpath("//*[@id='category_content']/tr[2]/td[3]").text
    
    save_to "results.json", item, format: :pretty_json
  end
end