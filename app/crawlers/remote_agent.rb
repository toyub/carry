class RemoteAgent
  include Agentable

  def initialize(user_agent = nil)
    @agent = Remote.new
  end

  def fetch(url)
    $crawler_logger.info("开始抓取")
    begin
      page = @agent.get(url)
    rescue Exception => e
      $crawler_logger.info("抓取失败: url: #{url}, message: #{e.message}, backtrace: #{e.backtrace.join("\n")}")
      page = nil
    end
    $crawler_logger.info("抓取结束")
    page
  end
end
