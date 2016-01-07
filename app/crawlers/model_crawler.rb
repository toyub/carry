class ModelCrawler
  include Crawlable

  def process_page_results(page)
    page.search('.interval01-list').shift
    page.search('.interval01-list').search('li')
  end
end
