class XiaoshouController < ApplicationController
  before_filter :login_required

  def main
    @data = to_builder
  end

  private
  def to_builder
    Jbuilder.encode do |json|
      json.(current_store, :id, :name)
      json.materials current_store.store_materials, :id, :name, :price
      json.packages current_store.store_packages do |package|
        json.(package, :id, :name, :code, :abstract, :remark, :price)
        json.(package_setting, :id, :period, :period_unit, :point)
      end
      json.commissions current_store.commission_templates, :id, :name
      json.services current_store.store_services, :id, :name, :code, :bargain_price, :point, :retail_price
      json.root_material_categories current_store.root_material_categories do |c|
        json.(c, :id, :store_id, :parent_id, :name)
        json.sub_categories c.sub_categories do |s|
          json.(s, :id, :store_id, :parent_id, :name)
        end
      end
    end
  end
end
