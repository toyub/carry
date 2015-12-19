module ViewHelper
  def is_hover(controller_name, namespace=nil, opt={})
    if namespace.present? && namespace.is_a?(Hash)
      opt = namespace
      namespace = nil
    end
    dom_class_name = opt[:dom_class].present? ? opt[:dom_class] : 'hover'
    action_name=opt[:action_name]
    if namespace.present? && controller_name.present? && action_name.present?
      "#{params[:controller]}/#{params[:action]}" == "#{namespace}/#{controller_name}/#{action_name}" ? dom_class_name : ''
    elsif controller_name.present? && action_name.present?
      "#{params[:controller]}/#{params[:action]}" == "#{controller_name}/#{action_name}" ? dom_class_name : ''
    elsif namespace.present? && controller_name.present?
      params[:controller] == "#{namespace}/#{controller_name}" ? dom_class_name : ''
    elsif controller_name.present? && namespace.blank? && action_name.blank?
      params[:controller] == controller_name ? dom_class_name : ''
    elsif namespace.present? && controller_name.blank? && action_name.blank?
      params[:controller] =~ /^#{namespace}\//i ? dom_class_name : ''
    else
      ""
    end
  end

  def breadcrumb_navigation(crumbs=[], redirect_path=nil)
    nav_str = "<h2>#{crumbs.join(' >')}</h2>"
    nav_str = nav_str + "<a class='back_to_list' href='#{redirect_path}'><i class='fa-arrow-circle-left fa'></i>返回列表</a>" if redirect_path
    nav_str.html_safe
  end
end
