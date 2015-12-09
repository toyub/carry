class Alipay

  def initialize(order)

    total_fee = order.amount
    subject = order.subject
    out_trade_no = order.numero
    key = ''
    secret = ''
    options ={
      :service=>"create_direct_pay_by_user",

      :subject=>"#{subject}#{total_fee}元",
      :payment_type=>1,

      :total_fee=>total_fee
    }


    options.merge!(:seller_email =>'', :partner =>key, :_input_charset=>"utf-8", :out_trade_no=>out_trade_no)
    options.merge!(:sign_type => "MD5", :sign =>Digest::MD5.hexdigest(options.sort.map{|k,v|"#{k}=#{v}"}.join("&")+secret))

    escaped_params = "#{options.sort.map{|k, v| "#{CGI::escape(k.to_s)}=#{CGI::escape(v.to_s)}"}.join('&')}"

    @url =  "https://www.alipay.com/cooperate/gateway.do?#{escaped_params}"
  end

  def url
    return @url
  end

end
