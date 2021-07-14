
# amazon_spider.rb
require 'kimurai'

class AmazonSpider < Kimurai::Base
  @name = "amazon_spider"
  @engine = :selenium_chrome
  @start_urls = ["https://www.amazon.com/"]

  def parse(response, url:, data: {})
    browser.fill_in "field-keywords", with: "Web Scraping Books"
    browser.click_on "Go"

    # Walk through pagination and collect products urls:
    urls = []
    loop do
      response = browser.current_response
      response.xpath("//li//a[contains(@class, 's-access-detail-page')]").each do |a|
        urls << a[:href].sub(/ref=.+/, "")
      end

      browser.find(:xpath, "//a[@id='pagnNextLink']", wait: 1).click rescue break
    end

    # Process all collected urls concurrently within 3 threads:
    in_parallel(:parse_book_page, urls, threads: 3)
  end

  def parse_book_page(response, url:, data: {})
    item = {}

    item[:title] = response.xpath("//h1/span[@id]").text.squish
    item[:url] = url
    item[:price] = response.xpath("(//span[contains(@class, 'a-color-price')])[1]").text.squish.presence
    item[:publisher] = response.xpath("//h2[text()='Product details']/following::b[text()='Publisher:']/following-sibling::text()[1]").text.squish.presence

    save_to "books.json", item, format: :pretty_json
  end
end

AmazonSpider.crawl!