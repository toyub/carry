require "openssl"

# MD5 加密实现类
# 
# 使用md5来加密字符串和Hash
# 
# 调用方式:
#   Mis::Utils::Encryption.md5(datas)
module Mis::Utils::Encryption

  class MD5
    class << self
      def encode(datas)
        if datas.is_a? Hash
          encrypt(hash_to_str(datas))
        elsif datas.is_a? String
          encrypt(datas)
        end
      end

      def hash_to_str(hash)
        hash.map do |k, v|
          if v.is_a? Hash
            [k, hash_to_str(v)]
          elsif v.is_a? Array
            [k, v.join("-")]
          else
            [k, v]
          end
        end.sort_by{|x| x[0].to_s}.map{|x| x.join("=")}.join("&")
      end

      def encrypt(str)
        OpenSSL::Digest::MD5.new(str).to_s
      end
    end
  end

end
