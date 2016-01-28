module Entities
  class CurrentStoreStaff < Grape::Entity
    expose :login_name, :full_name, :photo
    expose(:position) {|model| model.store_position.try(:name)}
    expose(:department) {|model| model.store_department.try(:name)}
    expose(:store_name) {|model| model.store.name}
  end
  class Session < Grape::Entity
    expose(:authorization) {|model| model.token}
    expose :current_staff, using: CurrentStoreStaff

    def current_staff
      object.store_staff
    end
  end
end
