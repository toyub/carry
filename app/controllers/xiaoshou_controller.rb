class XiaoshouController < ApplicationController
  before_filter :login_required

  def main
    @data = to_builder
  end

  private
  def to_builder
    Jbuilder.encode do |json|
      json.(current_store, :id, :name, :engineer_levels)
      json.materials current_store.store_materials, :id, :name, :price, :category_id, :root_category_id
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
      json.customers current_store.store_customer_entities do |entity|
        json.(entity, :id, :region, :address, :remark, :property, :store_customer_category_id)
        json.store_customer entity.store_customer, :phone_number, :full_name, :operator
      end
      json.customer_categories current_store.store_customer_categories, :id, :name
      json.root_material_categories current_store.root_material_categories do |c|
        json.(c, :id, :store_id, :parent_id, :name)
        json.sub_categories c.sub_categories do |s|
          json.(s, :id, :store_id, :parent_id, :name)
        end
      end
      json.tags current_store.tags, :id, :name
      json.provinces Geo.provinces(1), :name, :code
    end
  end
end
