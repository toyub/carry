require 'hashids'

# PrettyId 加密实现类
# 
# 用来生成10位字母的伪ID
# 
# 调用方式:
#   Mis::Utils::Encryption.pretty_id(datas)
module Mis::Utils::Encryption

 
  class PrettyId

    SALT = 'zhwa23n43!mi*s'
    LENGTH = 10

    ENGINE = Hashids.new(SALT, LENGTH)

    class << self

      # Encoding
      # Mis::Utils::Encryption::PrettyId.encode(obj_id)
      def encode(obj_id)
        PrettyId::ENGINE.encode(obj_id)
      end

      def decode(pretty_id)
        PrettyId::ENGINE.decode(pretty_id)
      end
     
    end
  end

end
