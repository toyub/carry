class AddChainBusinessModelIdToStore < ActiveRecord::Migration
  def change
    add_column :stores, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_customers, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_customer_entities, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_vehicles, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'

    add_column :store_customer_asset_items, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_customer_asset_logs, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_customer_assets, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_customer_categories, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_customer_deposit_logs, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_customer_payments, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_customer_settlements, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    

    add_column :store_staff, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'

    add_column :store_orders, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_order_items, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_order_repayments, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'


    add_column :store_suppliers, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'

    add_column :store_material_brands, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_categories, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_checkin_items, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_checkins, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_commissions, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_inventories, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_inventory_records, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_logs, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_manufacturers, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_order_items, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_order_payments, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_orders, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_outing_items, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_outings, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_picking_items, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_pickings, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_receipts, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_returning_items, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_returnings, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_saleinfo_categories, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_saleinfo_services, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_saleinfos, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_shrinkage_items, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_shrinkages, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_snapshots, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_tracking_sections, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_trackings, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_trans_receipt_items, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_material_units, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'

    add_column :store_services, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_deposit_cards, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_packages, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'
    add_column :store_package_items, :chain_business_model_id, :integer, default: 0, null:false, comment: '门店加入连锁时选择的商业模式，目前有连锁模式和加盟模式，默认是连锁模式（0）'

  end
end
