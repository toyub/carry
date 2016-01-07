class ModelCrawler
  include Crawlable

  def process_page_results(page)
    page.search('.interval01-list').shift
    models = page.search('.interval01-list').search('li')
    models.map do |model|
      name = model.search('p').first.text.split
      VehicleModel.create({
        manufacturing_year: name.shift.chop,
        name: name.join(' ')
      })
    end
  end
end
