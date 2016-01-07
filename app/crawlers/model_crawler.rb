class ModelCrawler
  include Crawlable

  def process_page_results(page)
    page.search('.interval01-list li')
  end
end
