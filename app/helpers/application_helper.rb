module ApplicationHelper
  def controller_namespace(params)
    kontroller_paths = params[:controller].split('/')
    kontroller_paths.first
  end

  def json_for(target, options = {})
    options[:scope] ||= self
    options[:url_options] ||= url_options
    ActiveModel::Serializer.serializer_for(target).new(target, options).to_json
  end

  def include_javascript_by_namespace
    namespace = params[:controller].split('/')[0]
    if ["kucun", "settings", "soa", "xianchang", "xiaoshou", "pos", "sas", "crm"].include?(namespace)
      content_for :pre_assets do
        javascript_include_tag namespace
      end
    end
  end
end
