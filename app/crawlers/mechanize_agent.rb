class MechanizeAgent
  include Agentable

  def initialize(user_agent = nil)
    @agent = Mechanize.new { |a|
      a.user_agent_alias = user_agent || 'Mac Safari'
    }
    #@agent.set_proxy Setting.proxy.host, Setting.proxy.port
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
