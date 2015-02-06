module ApplicationHelper
  def controller_namespace(params)
    params[:controller].gsub(/(\w+)\/\w+/, '\1')
  end
end
