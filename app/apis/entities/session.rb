module Entities
  class CurrentStoreStaff < Grape::Entity
    expose :login_name, :full_name, :photo, :store_id, :store_chain_id
    expose(:position) {|model| model.store_position.try(:name)}
    expose(:department) {|model| model.store_department.try(:name)}
    expose(:store_name) {|model| model.store.name}
  end
  class Session < Grape::Entity
    expose :status
    expose(:authorization) {|model| model.token}
    expose :current_staff, using: CurrentStoreStaff

    def current_staff
      object.store_staff
    end

    def status
      "登陆成功!"
    end
  end
end
