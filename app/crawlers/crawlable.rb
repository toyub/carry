# DIP(依赖倒置) 抓取数据的接口，底层app应依赖于此接口编程，具体的处理策略strategy也应针对此接口
## 具体使用方法：
=begin
  class YourCrawlableStrategy
    include Crawlable

    def process_page_results(page)
      // your business code
    end
  end

  然后你就可以调用helper方法抓取
  YourCrawlableStrategy.crawl(url)
=end

module Crawlable
  extend ActiveSupport::Concern

  def self.included(klass)
    klass.send(:include, InstanceMethods)
    klass.extend ClassMethods
  end
  
  module InstanceMethods
    def initialize(website)
      @website = website
    end
  
    # 子类需实现此方法
    # 此处提供一个缺省实现
    def website
      @website
    end
    
    # 子类需实现此方法
    # params: page, nokogiri page
    def process_page_results(page)
      raise 'Called abstract method: process_page_results'
    end
  end
  
  module ClassMethods
    # helper方法，便于简便调用
    def crawl(website)
      #CrawlerRunner.new( self.new(website), MechanizeAgent.new ).crawl if website.present?
      CrawlerRunner.new( self.new(website), RemoteAgent.new ).crawl if website.present?
    end
  end
end
