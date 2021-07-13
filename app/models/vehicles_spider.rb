class VehiclesSpider < Kimurai::Base
  @name = 'vehicles_spider'
  @engine = :mechanize

  def self.process(url)
    @start_urls = [url]
    self.crawl!
  end

  def parse(response, url:, data: {})
    response.xpath("//div[@class='shop-srp-listings__listing-container']").each do |vehicle|
      item = {}

      item[:title]      = vehicle.css('h2.listing-row__title')&.text&.squish
      item[:price]      = vehicle.css('span.listing-row__price')&.text&.squish&.delete('^0-9').to_i
      item[:stock_type] = vehicle.css('div.listing-row__stocktype')&.text&.squish
      item[:miles]      = vehicle.css('span.listing-row__mileage')&.text&.squish&.delete('^0-9').to_i
      item[:exterior_color] = vehicle.css('ul.listing-row__meta li')[0]&.text&.squish.gsub('Ext. Color: ', '')
      item[:interior_color] = vehicle.css('ul.listing-row__meta li')[1]&.text&.squish.gsub('Int. Color: ', '')
      item[:transmission] = vehicle.css('ul.listing-row__meta li')[2]&.text&.squish.gsub('Transmission: ', '')
      item[:drivetrain]   = vehicle.css('ul.listing-row__meta li')[3]&.text&.squish.gsub('Drivetrain: ', '')

      Vehicle.where(item).first_or_create
    end
  end
end