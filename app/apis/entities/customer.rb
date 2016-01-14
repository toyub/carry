module Entities
  class Customer < Grape::Entity
    expose :id, documentation: {type: Integer, desc: "ID"}
    expose :full_name, documentation: {type: String, desc: "姓名"}
    expose :telephone, documentation: {type: String, desc: "电话"}
    expose :store_id, documentation: {type: Integer, desc: "所属门店ID"}
  end
end
