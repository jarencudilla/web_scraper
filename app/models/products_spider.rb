require 'kimurai'
require 'net/http'
require 'open-uri'
require 'webdrivers'

class ProductsSpider < Kimurai::Base
  @name = 'products_spider'
  @engine = :selenium_chrome
  @start_urls = ['https://www.amazon.com/s?k=motherboard']
  @config = {
    user_agent: 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36',
    before_request: { delay: 4..7 }
  }

  def parse(response, url:, data: {})
    response.xpath("/html/body/div[1]/div[2]/div[1]/div/div[1]").each do |a|
      request_to :parse_repo_page, url: absolute_url(a[:href], base: url)
    end

    if next_page = response.at_xpath("/html/body/div[1]/div[2]/div[1]/div/div[1]/div/span[3]/div[2]/div[23]/span/div/div/ul/li[7]")
      request_to :parse, url: absolute_url(next_page[:href], base: url)
    end
  end

  def parse_repo_page(response, url:, data: {})
    item = {}

    item[:item_name] = response.xpath("/html/body/div[1]/div[2]/div[1]/div/div[1]/div/span[3]/div[2]/div[2]/div/span/div/div/div[2]/div[2]/div/div/div[1]/h2").text
    item[:item_description] = response.xpath("/html/body/div[1]/div[2]/div[1]/div/div[1]/div/span[3]/div[2]/div[2]/div/span/div/div/div[2]/div[2]/div/div/div[3]/div[1]/div/div[1]/div/a").text
    
    save_to "results.json", item, format: :pretty_json
  end
end
