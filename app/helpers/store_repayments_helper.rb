module StoreRepaymentsHelper
  def account_nav(customer)
    nav = {
      '未清账单' => :hanging,
      '已清挂账' => :finished,
      '所有挂账' => :index
    }
    html = ""
    nav.each do |k,v|
      active = 'active' if v.to_s == params[:action]
      html += "<li><a "
      html += k == "所有挂账" ? "href='/crm/store_customers/#{customer.id}/store_repayments'" : "href='/crm/store_customers/#{customer.id}/store_repayments/#{v}'"
      html += "class='#{active} width-90 tab_item'>#{k}</a></li>"
    end
    html.html_safe
  end
end
