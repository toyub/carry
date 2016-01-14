require 'faraday'
require 'typhoeus'
require 'typhoeus/adapters/faraday'

class Remote
  def get(url)
    conn = Faraday.new(url: url) do |faraday|
      faraday.request :url_encoded
      faraday.adapter :typhoeus
    end
    
    html = conn.get.body
    Nokogiri::HTML.parse html.force_encoding('gb2312')
  end
end
