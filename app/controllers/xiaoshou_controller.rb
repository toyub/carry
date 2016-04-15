class XiaoshouController < ApplicationController
  before_filter :login_required

  def main
    @data = to_builder
  end

  private
  def to_builder
    Jbuilder.encode do |json|
      json.(current_store, :id, :name, :engineer_levels)
      json.packages current_store.store_packages.order("id asc") do |package|
        json.(package, :id, :name, :code, :abstract, :remark, :price)
        json.package_setting do
          json.id package.package_setting.id
          json.period package.package_setting.period
          json.period_unit package.package_setting.period_unit
          json.point package.package_setting.point
          json.retail_price package.package_setting.retail_price
        end
      end
      json.customer_categories current_store.store_customer_categories, :id, :name
      json.commissions current_store.commission_templates, :id, :name
      json.machanic_commissions current_store.commission_templates.for_machanic, :id, :name
      json.services current_store.store_services.order("id asc"), :id, :name, :code, :bargain_price, :bargain_price_enabled, :point, :retail_price, :standard_time, :engineer_level, :category, :category_name, :saleman_commission_template_id, :vip_price_enabled
      json.service_categories ServiceCategory.all, :id, :name
      json.customers current_store.store_customer_entities do |entity|
        json.(entity, :id, :region, :address, :remark, :property, :store_customer_category_id)
        json.store_customer entity.store_customer, :phone_number, :full_name, :operator,
                                                   :vehicles_count, :orders_count, :total_amount,
                                                   :has_customer_asset, :integrity, :activeness
      end
      json.customer_categories current_store.store_customer_categories, :id, :name
      json.root_material_categories current_store.root_material_categories do |c|
        json.(c, :id, :store_id, :parent_id, :name)
        json.sub_categories c.sub_categories do |s|
          json.(s, :id, :store_id, :parent_id, :name)
        end
      end
      json.materials current_store.store_material_saleinfos.exclude_service.joins(:store_material).where(store_materials: {permitted_to_saleable: true}), :id, :name, :retail_price
      json.tags current_store.tags, :id, :name
      json.provinces Geo.provinces(1), :name, :code
      json.workstations current_store.workstations, :id, :name
    end
  end
end
