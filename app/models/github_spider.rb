require 'kimurai'
require 'webdrivers'

class Spider < Kimurai::Base
  @name = ''
  @start_urls = []
  @engine = :selenium_chrome
  @config = {
    user_agent: "Chrome/68.0.3440.84"
  }
  def self.process()
    self.crawl!
  end
end

require 'kimurai'

class ProductsSpider < Kimurai::Base
  @name = 'products_spider'
  @engine = :mechanize
  @start_urls = ['https://pcpartpicker.com/products/motherboard/']
  @config = {
    user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
    before_request: { delay: 4..7 }
  }

  def parse(response, url:, data: {})
    response.xpath('//*[@class="productList--detailed xs-col-12 tablesorter tablesorter-default"]').each do |a|
      request_to :parse_repo_page, url: absolute_url(a[:href], base: url)
    end

    if next_page = response.at_xpath('//*[@class="pagination list-unstyled xs-text-center"]')
      request_to :parse, url: absolute_url(next_page[:href], base: url)
    end
  end

  def parse_repo_page(response, url:, data: {})
    item = {}

    item[:item_name] = response.xpath('//*[@class="td__name"]').text
    item[:item_description] = response.xpath('//*[@id="td__spec td__spec--1"]').text
    
    save_to "results.json", item, format: :pretty_json
  end
end