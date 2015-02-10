module ViewHelper
  def is_hover(controller_name, namespace=nil, opt={})
    action_name=opt[:action_name]
    if namespace.present? && controller_name.present? && action_name.present?
      "#{params[:controller]}/#{params[:action]}" == "#{namespace}/#{controller_name}/#{action_name}" ? 'hover' : ''
    elsif controller_name.present? && action_name.present?
      "#{params[:controller]}/#{params[:action]}" == "#{controller_name}/#{action_name}" ? 'hover' : ''
    elsif namespace.present? && controller_name.present?
      params[:controller] == "#{namespace}/#{controller_name}" ? 'hover' : ''
    elsif controller_name.present? && namespace.blank? && action_name.blank?
      params[:controller] == controller_name ? 'hover' : ''
    elsif namespace.present? && controller_name.blank? && action_name.blank?
      params[:controller] =~ /^#{namespace}\//i ? 'hover' : ''
    else
      ""
    end
  end
end