class ProductsSpider < Kimurai::Base
  @name = 'products_spider'
  @engine = :mechanize

  def self.process(url)
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})
    response.xpath("I should put a URL here? i think").each do |vehicle|
      item = {}

     

      Product.where(item).first_or_create
    end
  end
end