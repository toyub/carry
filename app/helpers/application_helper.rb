module ApplicationHelper
  def controller_namespace(params)
    params[:controller].gsub(/(\w+)\/\w+/, '\1')
  end

  def json_for(target, options = {})
    options[:scope] ||= self
    options[:url_options] ||= url_options
    ActiveModel::Serializer.serializer_for(target).new(target, options).to_json
  end
end
