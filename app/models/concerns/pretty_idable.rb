# 为Model添加生成伪ID的功能
# 
# Demo:
#   class User
#     include PrettyIdable
#   end
# 
#   pretty_id = User.first.pretty_id
#   user = User.find_by_pretty_id(pretty_id)
module PrettyIdable
  extend ActiveSupport::Concern


  def pretty_id
    Mis::Utils::Encryption.pretty_id(id)
  end

  module ClassMethods

    def find_by_pretty_id(pretty_id)
      obj_id = Mis::Utils::Encryption.decode_pretty_id(pretty_id)
      return if obj_id.blank?
      find(obj_id)
    end

  end

end
