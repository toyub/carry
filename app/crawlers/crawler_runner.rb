# 抓取数据的触发者、施动者，也即strategy模式的高层
class CrawlerRunner
  def initialize(crawlable, agentable)
    @crawlable = crawlable
    @agentable = agentable
  end

  def crawl
    url = website
    page = fetch(url)
    process_page_results(page) if page
  end

  # returns: page, nokogiri page
  def fetch(url)
    @agentable.fetch(url)
  end

  def website
    @crawlable.website
  end

  def process_page_results(page)
    @crawlable.process_page_results(page)
  rescue => e
    $crawler_logger.error("message: #{e.message}, backtrace: #{e.backtrace.join("\n")}")
  end
end
