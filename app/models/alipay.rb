class Alipay
  begin
    alipay_config = YAML.load_file("#{Rails.root}/config/alipay.yml").with_indifferent_access
    @@partner = alipay_config[:partner]
    @@service = alipay_config[:service]

    @@options = {
      service: "create_direct_pay_by_user",
      payment_type: 1,
      seller_email: @@partner[:email], 
      partner: @@partner[:key],
      _input_charset:"utf-8",
      return_url: alipay_config[:callback][:return_url],
      notify_url: alipay_config[:callback][:notify_url]
    }
  rescue Exception => e
    puts e.message
  end

  def initialize(order)
    unless (@@partner && @@service)
      raise 
    end
    options = @@options.merge({
          total_fee: order.amount,
          subject: order.subject,
          out_trade_no: order.numero
     })
    options[:sign] = Digest::MD5.hexdigest(URI.decode(options.sort.to_h.to_param)+@@partner[:secret])
    options[:sign_type] = "MD5"
    escaped_params = options.sort.to_h.to_param
    @url =  "#{@@service[:gateway]}?#{escaped_params}"
  end

  def url
    return @url
  end

end
