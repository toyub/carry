# 为Model添加生成随机字符串的功能
# 
# Demo:
#   class User
#     include RandomTextable
#
#     random :attr
#   end
module RandomTextable
  extend ActiveSupport::Concern

  module ClassMethods

    def random(field)
      validates field.to_sym, presence: true, uniqueness: true

      before_validation "set_#{field}_random", if: -> { self.send(field.to_sym).blank? }

      define_method "set_#{field}_random" do
        while true
          text = Mis::Utils::Random.text
          break unless self.class.exists?("#{field}": text)
        end
        self.send("#{field}=", text)
      end
    end

  end

end
