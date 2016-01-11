class StoreOrganizationSerializer < ActiveModel::Serializer
  attr_accessor :data
  def initialize(store)
    @data = {
      id: store.id,
      name: store.try(:name),
      departments: [],
      commission_level: StoreStaffLevel::ID_TYPES
    }
    set_data(store)
  end

  private
  def set_data(store)
    store.store_departments.each_with_index do |department, i|
      @data[:departments][i] = {
          id: department.id,
          name: department.try(:name),
          positions: []
      }
      department.store_positions.each do |position|
        @data[:departments][i][:positions] << {
          id: position.id,
          name: position.try(:name),
        }
      end
    end
  end
end
