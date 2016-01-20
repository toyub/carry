module Entities
  class Store < Grape::Entity
    expose :id, :name
    expose :customer_categories do |store, options|
      store.store_customer_categories.map do |category|
        {
          id: category.id,
          name: category.name
        }
      end
    end
    expose :commission
    expose :departmentsd do |store, options|
      store.store_departments.map do |department|
        {
          id: department.id,
          name: department.name,
          positions: department.store_positions.map do |position|
            {
              id: position.id,
              name: position.name
            }
          end
        }
      end
    end
    expose (:province) { |store, options| store.province }
    expose (:city) { |store, options| store.city }
    expose (:admin) { |store, options| store.admin.try(:full_name) }
    expose (:phone_number) { |store, options| store.admin.try(:phone_number) }
    expose (:address) { |store, options| store.address }
    expose (:created_at) { |store, options| store.created_at.strftime('%Y-%m-%d') }
    expose (:business_status) { |store, options| store.business_status }
    expose (:business_hours) { |store, options| store.business_hours }
    expose (:last_year_sales) { |store, options| store.last_year_sales }
    expose (:current_year_sales) { |store, options| store.current_year_sales }

    private

      def commission
        StoreStaffLevel::ID_TYPES
      end

  end
end
