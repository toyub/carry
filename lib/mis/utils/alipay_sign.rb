module Mis
  module Utils
    module AlipaySign
      class << self

        def sign(options, md5key)
          Digest::MD5.hexdigest(hash_to_query_like_string(options) + md5key)
        end

        def hash_to_query_like_string(hash)
          hash.sort.map(&->(key, value){"#{key}=#{value}"}).join('&')
        end
      end
    end
  end
end
