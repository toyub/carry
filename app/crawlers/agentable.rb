# 抓取时所使用的agent，具体的抓取都通过fetch方法实现，子类必须实现此方法
module Agentable
  def fetch(url)
    raise 'Called abstract method: fetch'
  end
end