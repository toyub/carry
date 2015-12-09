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
      _input_charset:"utf-8"
    }
  rescue Exception => e
    puts e.message
  end

  def initialize(order)
    unless (@@partner && @@service)
      raise 
    end
    total_fee = order.amount
    subject = order.subject
    out_trade_no = order.numero
    
    options =@@options.merge({
          total_fee: total_fee,
          subject: "#{subject}#{total_fee}元",
          out_trade_no: out_trade_no
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
