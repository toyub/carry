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
    expose :departments do |store, options|
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
    expose :province
    expose :city
    expose(:admin) { |store, options| store.admin.try(:full_name) }
    expose(:phone_number) { |store, options| store.admin.try(:phone_number) }
    expose :address
    expose(:created_at) { |store, options| store.created_at.strftime('%Y-%m-%d') }
    expose :business_status
    expose :business_hours
    expose :last_year_sales
    expose :current_year_sales

    private

      def commission
        StoreStaffLevel::ID_TYPES
      end

  end
end
