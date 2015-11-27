class XiaoshouController < ApplicationController
  before_filter :login_required

  def main
    @data = to_builder
  end

  private
  def to_builder
    Jbuilder.encode do |json|
      json.(current_store, :id, :name, :engineer_levels)
      json.materials current_store.store_materials, :id, :name, :price
      json.packages current_store.store_packages do |package|
        json.(package, :id, :name, :code, :abstract, :remark, :price)
        json.package_setting do
          json.id package.package_setting.id
          json.period package.package_setting.period
          json.period_unit package.package_setting.period_unit
          json.point package.package_setting.point
        end
      end
      json.customer_categories current_store.store_customer_categories, :id, :name
      json.commissions current_store.commission_templates, :id, :name
      json.services current_store.store_services, :id, :name, :code, :bargain_price, :point, :retail_price
      json.customers current_store.store_customers, :id, :full_name, :mobile, :satisfaction, :integrity
      json.root_material_categories current_store.root_material_categories do |c|
        json.(c, :id, :store_id, :parent_id, :name)
        json.sub_categories c.sub_categories do |s|
          json.(s, :id, :store_id, :parent_id, :name)
        end
      end
      json.provinces Geo.provinces(1), :name, :code
      json.cities Geo.cities(1, 11), :name, :code
    end
  end
end
