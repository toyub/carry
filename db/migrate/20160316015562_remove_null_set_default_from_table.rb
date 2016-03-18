class RemoveNullSetDefaultFromTable < ActiveRecord::Migration
  def change
    change_column :renewal_records, :renewal_money, :decimal, precision: 12, scale: 2

    change_column :store_material_checkin_items, :price, :decimal, precision: 12, scale: 2
    change_column :store_material_checkin_items, :amount, :decimal, precision: 14, scale: 4
    change_column :store_material_checkin_items, :prior_cost_price, :decimal, precision: 12, scale: 2
    change_column :store_material_checkin_items, :latest_cost_price, :decimal, precision: 12, scale: 2
    change_column :store_material_checkins, :amount, :decimal, precision: 14, scale: 4

    change_column :store_material_inventories, :cost_price, :decimal, precision: 12, scale: 2
    change_column :store_material_inventory_records, :prior_cost_price, :decimal, precision: 12, scale: 2
    change_column :store_material_inventory_records, :ordered_cost_price, :decimal, precision: 12, scale: 2
    change_column :store_material_inventory_records, :latest_cost_price, :decimal, precision: 12, scale: 2

    change_column :store_material_order_items, :price, :decimal, precision: 12, scale: 2
    change_column :store_material_order_items, :amount, :decimal, precision: 14, scale: 4
    change_column :store_material_order_payments, :order_balance, :decimal, precision: 14, scale: 4
    change_column :store_material_order_payments, :amount, :decimal, precision: 14, scale: 4
    change_column :store_material_orders, :amount, :decimal, precision: 14, scale: 4
    change_column :store_material_orders, :paid_amount, :decimal, precision: 14, scale: 4

    change_column :store_material_outing_items, :amount, :decimal, precision: 14, scale: 4
    change_column :store_material_outing_items, :cost_price, :decimal, precision: 12, scale: 2
    change_column :store_material_outing_items, :inventory_cost_price, :decimal, precision: 12, scale: 2
    change_column :store_material_outings, :total_amount, :decimal, precision: 14, scale: 4

    change_column :store_material_picking_items, :cost_price, :decimal, precision: 12, scale: 2, default: 0.0
    change_column :store_material_picking_items, :inventory_cost_price, :decimal, precision: 12, scale: 2, default: 0.0
    change_column :store_material_picking_items, :amount, :decimal, precision: 14, scale: 4
    change_column :store_material_pickings, :total_amount, :decimal, precision: 14, scale: 4
    change_column :store_material_pickings, :total_inventory_amount, :decimal, precision: 14, scale: 4

    change_column :store_material_returning_items, :price, :decimal, precision: 12, scale: 2, default: 0.0
    change_column :store_material_returnings, :total_amount, :decimal, precision: 14, scale: 4, default: 0.0

    change_column :store_material_saleinfos, :bargain_price, :decimal, precision: 12, scale: 2, default: 0.0
    change_column :store_material_saleinfos, :retail_price, :decimal, precision: 12, scale: 2, default: 0.0
    change_column :store_material_saleinfos, :trade_price, :decimal, precision: 12, scale: 2, null: true, default: 0.0
    change_column :store_material_saleinfos, :service_fee, :decimal, precision: 12, scale: 2, default: 0.0

    change_column :store_material_shrinkage_items, :cost_price, :decimal, precision: 12, scale: 2
    change_column :store_material_shrinkage_items, :inventory_cost_price, :decimal, precision: 12, scale: 2
    change_column :store_material_shrinkage_items, :amount, :decimal, precision: 14, scale: 4
    change_column :store_material_shrinkages, :total_amount, :decimal, precision: 14, scale: 4

    change_column :store_material_snapshots, :cost_price, :decimal, precision: 12, scale: 2
    change_column :store_material_snapshots, :min_price, :decimal, precision: 12, scale: 2

    change_column :store_material_trans_receipt_items, :prior_cost_price, :decimal, precision: 12, scale: 2
    change_column :store_material_trans_receipt_items, :ordered_cost_price, :decimal, precision: 12, scale: 2
    change_column :store_material_trans_receipt_items, :inventory_cost_price, :decimal, precision: 12, scale: 2
    change_column :store_material_trans_receipt_items, :latest_cost_price, :decimal, precision: 12, scale: 2

    change_column :store_materials, :cost_price, :decimal, precision: 12, scale: 2
    change_column :store_materials, :min_price, :decimal, precision: 12, scale: 2

    change_column :store_order_items, :price, :decimal, precision: 12, scale: 2, default: 0.0
    change_column :store_order_items, :amount, :decimal, precision: 14, scale: 4, default: 0.0

    change_column :store_orders, :amount, :decimal, precision: 14, scale: 4, default: 0.0

    change_column :store_package_settings, :retail_price, :decimal, precision: 12, scale: 2, default: 0.0

    change_column :store_physical_inventory_items, :inventory_cost_price, :decimal, precision: 12, scale: 2, default: 0.0
    change_column :store_physical_inventory_items, :cost_price, :decimal, precision: 12, scale: 2, default: 0.0

    change_column :store_service_snapshots, :retail_price, :decimal, precision: 12, scale: 2, default: 0.0
    change_column :store_service_snapshots, :bargain_price, :decimal, precision: 12, scale: 2, default: 0.0
    change_column :store_services, :retail_price, :decimal, precision: 12, scale: 2, default: 0.0
    change_column :store_services, :bargain_price, :decimal, precision: 12, scale: 2, default: 0.0

    change_column :store_package_items, :price, :decimal, precision: 12, scale: 2, default: 0.0

    change_column :store_deposit_cards, :price, :decimal, precision: 12, scale: 2, default: 0.0
    change_column :store_deposit_cards, :denomination, :decimal, precision: 12, scale: 2, default: 0.0

    change_column :store_payments, :amount, :decimal, precision: 14, scale: 4, default: 0.0

    change_column :store_package_items, :denomination, :decimal, precision: 12, scale: 2
    change_column :store_packages, :price, :decimal, precision: 12, scale: 2

    change_column :orders, :amount, :decimal, precision: 14, scale: 4, comment: 'amount = sum(order_items.amount)'
    change_column :order_items, :price, :decimal, precision: 12, scale: 2
    change_column :order_items, :amount, :decimal, precision: 14, scale: 4

    change_column :payments, :amount, :decimal, precision: 14, scale: 4
    change_column :journal_entries, :balance, :decimal, precision: 14, scale: 4

    change_column :debits, :amount, :decimal, precision: 14, scale: 4
    change_column :credits, :amount, :decimal, precision: 14, scale: 4

    change_column :store_salaries, :amount_deduction, :decimal, precision: 14, scale: 4
    change_column :store_salaries, :amount_overtime, :decimal, precision: 14, scale: 4
    change_column :store_salaries, :amount_reward, :decimal, precision: 14, scale: 4
    change_column :store_salaries, :amount_bonus, :decimal, precision: 14, scale: 4
    change_column :store_salaries, :amount_insurence, :decimal, precision: 14, scale: 4
    change_column :store_salaries, :amount_cutfee, :decimal, precision: 14, scale: 4
    change_column :store_salaries, :amount_should_cutfee, :decimal, precision: 14, scale: 4
    change_column :store_salaries, :salary_should_pay, :decimal, precision: 14, scale: 4
    change_column :store_salaries, :salary_actual_pay, :decimal, precision: 14, scale: 4
    change_column :store_salaries, :basic_salary, :decimal, precision: 12, scale: 2, default: 0.0

    change_column :store_protocols, :previous_salary, :decimal, precision: 12, scale: 2
    change_column :store_protocols, :new_salary, :decimal, precision: 12, scale: 2

    change_column :store_customer_payments, :amount, :decimal, precision: 14, scale: 4

    change_column :store_orders, :filled, :decimal, precision: 14, scale: 4
    change_column :store_customer_settlements, :credit_bill_amount, :decimal, precision: 12, scale: 2, default: 0
    change_column :store_customer_settlements, :credit_limit, :decimal, precision: 12, scale: 2, default: 0

    change_column :store_material_saleinfos, :vip_price, :decimal, precision: 12, scale: 2
    change_column :store_material_saleinfos, :divide_volume_per_bill, :decimal, precision: 12, scale: 2, default: 0.0

    change_column :vehicle_models, :min_price, :decimal, precision: 12, scale: 2, default: 0.0
    change_column :vehicle_models, :max_price, :decimal, precision: 12, scale: 2, default: 0.0

    change_column :store_order_items, :price, :decimal, precision: 12, scale: 2, default: 0.0
    change_column :store_order_items, :vip_price, :decimal, precision: 12, scale: 2, default: 0.0
    change_column :store_order_items, :cost_price, :decimal, precision: 12, scale: 2, default: 0.0
    change_column :store_order_items, :retail_price, :decimal, precision: 12, scale: 2, default: 0.0

    change_column :store_material_receipts, :amount, :decimal, precision: 14, scale: 4, default: 0.0

    change_column :store_customer_deposit_logs, :latest, :decimal, precision: 12, scale: 2
    change_column :store_customer_deposit_logs, :amount, :decimal, precision: 14, scale: 4
    change_column :store_customer_deposit_logs, :balance, :decimal, precision: 14, scale: 4
  end
end
