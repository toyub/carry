module RemoteUrls
  def self.brand_uri
    'http://www.autohome.com.cn/ashx/AjaxIndexCarFind.ashx?type=1'
  end

  def self.factory_and_series_uri(brand_id)
    "http://www.autohome.com.cn/ashx/AjaxIndexCarFind.ashx?type=3&value=#{brand_id}"
  end

  def self.year_and_model_uri(series_id)
    "http://www.autohome.com.cn/ashx/AjaxIndexCarFind.ashx?type=5&value=#{series_id}"
  end
end