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

  def make_numero(type)
    utn=Time.now
    return "#{type}#{utn.strftime('%Y%m%d%H%M%S')}#{((utn.to_f - utn.to_i) * 100_0000).to_i.to_s(36).rjust(5, '0').upcase}"
  end

  def include_javascript_by_namespace
    namespace = params[:controller].split('/')[0]
    if ["kucun", "settings", "soa", "xianchang", "xiaoshou"].include?(namespace)
      content_for :pre_assets do
        javascript_include_tag namespace
      end
    end
  end

  def get_second_form_textvalue(staff, type)
    valueof = staff.store_protocols.operate_type(type)[0] || {}
    {
      type => {
              reason:     valueof.reason,
         effected_on:     valueof.effected_on,
          expired_on:     valueof.expired_on,
         verifier_id:     valueof.verifier_id,
              remark:     valueof.remark
      }
    }
  end
end
