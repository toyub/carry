# 加密工具集的统一出口
# 
# 方法命名规则:
#   加密方法: 对应实现类的
#   解密方法名为：  "decode_" + 对应的加密方法名
module Mis::Utils

  module Encryption

    class << self

      # Mis::Utils::Encryption.md5(datas)
      def md5(datas)
        Mis::Utils::Encryption::MD5.encode(datas)
      end

      # Mis::Utils::Encryption.pretty_id(obj_id)
      def pretty_id(obj_id)
        Mis::Utils::Encryption::PrettyId.encode(obj_id)
      end

      # Mis::Utils::Encryption.decode_pretty_id(obj_id)
      def decode_pretty_id(obj_id)
        Mis::Utils::Encryption::PrettyId.decode(obj_id)
      end

    end

  end

end

require_relative "encryption/md5"
require_relative "encryption/pretty_id"
