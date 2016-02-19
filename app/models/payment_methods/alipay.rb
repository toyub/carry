module PaymentMethods
  class Alipay
    include PaymentMethods::Base
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

    def self.valid_alipay_param?(options, sign, crypte_method='MD5')
      if crypte_method == 'MD5'
        return Mis::Utils::AlipaySign.sign(options, @@partner[:secret]) == sign
      end
    end

    def self.cn_name
      '支付宝'
    end

    def self.enumable_name
      'alipay'
    end

    def initialize(order)
      unless (@@partner && @@service)
        raise
      end
      options = @@options.merge({
            total_fee: order.amount,
            subject: order.subject,
            out_trade_no: order.pretty_id
       })
      options[:sign] = Mis::Utils::AlipaySign.sign(options, @@partner[:secret])
      options[:sign_type] = "MD5"
      escaped_params = options.sort.to_h.to_param
      @url =  "#{@@service[:gateway]}?#{escaped_params}"
    end

    def url
      return @url
    end

  end
end
