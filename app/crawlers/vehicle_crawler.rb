class VehicleCrawler
  include Crawlable

  def process_page_results(page)
    brands = page.search('dl')
    create_brands(brands, letter_by(page))
  end

  def letter_by(page)
    page.uri.to_s.split('.html').first[-1]
  end

  def create_brands(brands, letter)
    brands.each do |brand|
      vehicle_brand = VehicleBrand.create({
        name: brand.search('dt').text,
        letter: letter
      })
      vehicle_brand = VehicleBrand.find_or_create_by(name: brand.search('dt').text)
      manufacturers = brand.search('dd .h3-tit')
      create_manufacturers(manufacturers, vehicle_brand)
    end
  end

  def create_manufacturers(manufacturers, vehicle_brand)
    manufacturers.each do |manufacturer|
      vehicle_manufacturer = VehicleManufacturer.create(name: manufacturer.text)
      vehicle_brand.vehicle_manufacturers << vehicle_manufacturer
      series = manufacturer.next_element.elements
      create_series(series, vehicle_brand, vehicle_manufacturer)
    end
  end

  def create_series(series, vehicle_brand, vehicle_manufacturer)
    series.each do |s|
      next if s.attr(:class) == 'dashline'
      price_range = s.search('div a').first.text
      vehicle_series = VehicleSeries.create({
        name: s.search('h4').text,
        min: price_range.split('-').first,
        max: price_range.split('-').last.chop
      })
      vehicle_brand.vehicle_series << vehicle_series
      vehicle_manufacturer.vehicle_series << vehicle_series
      VehicleModelJob.perform_later(s.search('h4 a').first.attr('href'), vehicle_series)
    end
  end

  def self.crawl(website)
    CrawlerRunner.new( self.new(website), MechanizeAgent.new ).crawl if website.present?
  end
end
