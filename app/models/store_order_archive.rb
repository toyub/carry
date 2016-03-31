class StoreOrderArchive
  def initialize(payments_hash, order)
    @payments_hash = payments_hash
    @order = order
    @customer = order.store_customer
  end

  def reform
    ActiveRecord::Base.transaction do
      save_payments
      save_deposit_cards
      save_package_services
      save_taozhuang
      update_customer_assets
      reward_points
      pay_finish
      auto_outing
      deal_with_material_cost_price
    end
  end

  def save_payments
    amount = @payments_hash.map { |payment| payment[:amount].to_f }.sum
    raise ActiveRecord::Rollback unless @order.amount.to_f == amount
    @payments = @order.payments.create!(@payments_hash)
  end

  def save_deposit_cards
     @order.deposits_cards.each do |card|
        StoreCustomerDepositCard.create! store_id: @order.store_id,
                                         store_chain_id: @order.store_chain_id,
                                         store_customer_id: @order.store_customer_id,
                                         store_vehicle_id: @order.store_vehicle_id,
                                         package: card.store_package_setting.store_package,
                                         package_name: card.store_package_setting.store_package.name,
                                         items_attributes: [{store_id: @order.store_id,
                                                             store_chain_id: @order.store_chain_id,
                                                             store_customer_id: @order.store_customer_id,
                                                             assetable: card,
                                                             total_quantity: 1,
                                                             used_quantity: 1}]

        StoreCustomerDepositIncome.create! store_id: @order.store_id,
                                           store_chain_id: @order.store_chain_id,
                                           store_customer_id: @order.store_customer_id,
                                           store_vehicle_id: @order.store_vehicle_id,
                                           store_order_id: @order.id,
                                           latest: @customer.store_customer_entity.balance.to_f,
                                           amount: card.denomination.to_f
        @customer.store_customer_entity.membership! unless @customer.store_customer_entity.membership?
        @customer.store_customer_entity.increase_balance!(card.denomination)
     end
  end

  def save_package_services
    @package_service_assets = []
    @immediate_used_package_items = @order.items.where(from_customer_asset: true, package_type: StorePackage.name)
    @order.packages.each do |order_item|
      if order_item.orderable.contain_service?
        order_item.quantity.times do
          items_attributes = order_item.orderable
                                         .package_setting
                                         .items
                                         .packaged_services.map do |package_item|
                                                                {store_id: @order.store_id,
                                                                 store_chain_id: @order.store_chain_id,
                                                                 store_customer_id: @order.store_customer_id,
                                                                 assetable: package_item.package_itemable,
                                                                 package_item: package_item,
                                                                 total_quantity: package_item.quantity,
                                                                 workflowable_hash: package_item.package_itemable.to_workflowable_hash
                                                               }
                                                  end
          @package_service_assets << StoreCustomerPackagedService.create!(store_id: @order.store_id,
                                                                          store_chain_id: @order.store_chain_id,
                                                                          store_customer_id: @order.store_customer_id,
                                                                          store_vehicle_id: @order.store_vehicle_id,
                                                                          package: order_item.orderable,
                                                                          package_name: order_item.orderable.name,
                                                                          items_attributes: items_attributes)
        end
       end
    end
    check_customer_asset_item(@package_service_assets, @immediate_used_package_items)
  end

  def save_taozhuang
    @taozhuang_service_assets = []
    @immediate_used_taozhuang_items = @order.items.where(from_customer_asset: true, package_type: StoreMaterialSaleinfo.name)
    @order.taozhuangs.each do |order_item|
      if order_item.orderable.service_needed
        order_item.quantity.times do
          items_attributes = order_item.orderable.services.map do |taozhuang_item|
                                                        {store_id: @order.store_id,
                                                         store_chain_id: @order.store_chain_id,
                                                         store_customer_id: @order.store_customer_id,
                                                         assetable: taozhuang_item,
                                                         package_item: taozhuang_item,
                                                         total_quantity: taozhuang_item.quantity,
                                                         workflowable_hash: taozhuang_item.as_json
                                                       }
                                                  end
          @taozhuang_service_assets << StoreCustomerTaozhuang.create!(store_id: @order.store_id,
                                         store_chain_id: @order.store_chain_id,
                                         store_customer_id: @order.store_customer_id,
                                         store_vehicle_id: @order.store_vehicle_id,
                                         package: order_item.orderable,
                                         package_name: order_item.orderable.name,
                                         items_attributes: items_attributes)
        end
      end
    end
    check_customer_asset_item(@taozhuang_service_assets, @immediate_used_taozhuang_items)
  end

  def update_customer_assets
    customer_asset_items = @order.items.where("store_customer_asset_item_id IS NOT NULL AND from_customer_asset = 'true'")
    customer_asset_items.each do |item|
      item.store_customer_asset_item.increment!(:used_quantity, 1)
      item.store_customer_asset_item.logs.create! store_id: @order.store_id,
                                      store_chain_id: @order.store_chain_id,
                                      store_customer_id: @order.store_customer_id,
                                      store_vehicle_id: @order.store_vehicle_id,
                                      store_order_id: @order.id,
                                      store_order_item_id: item.id,
                                      latest: 1,
                                      quantity: 1,
                                      balance: item.store_customer_asset_item.left_quantity
    end
  end

  def reward_points
    points = @order.items.map{|item| item.orderable.try(:point).to_i}.sum
    @customer.store_customer_entity.increase_points!(points)
  end

  def pay_finish
    @order.paid_at = Time.now
    if @order.payments.any?(&->(pi){pi.hanging?})
      @order.hanging!
      @customer.store_customer_entity.store_customer_settlement.increase_credit_bill_amount!(@order.amount)
    else
      @order.pay_finished!
    end

    if @order.task_finished?
      @order.finished!
    end
    true
  end

  def auto_outing
    depot = @order.store.store_depots.current_preferred
    depot.outing_order_materials!(@order)
  end

  def deal_with_material_cost_price
    @order.items.materials.each do |order_item|
      if order_item.orderable.divide_to_retail?
        order_item.divide_to_retail = true
        order_item.standard_volume_per_bill = order_item.orderable.divide_volume_per_bill
        order_item.actual_volume_per_bill = order_item.orderable.divide_volume_per_bill
        order_item.save!
      else
        order_item.update!(cost_price: order_item.orderable.cost_price)
      end
    end
  end

  private
  def check_customer_asset_item(customer_assets, used_items)
    customer_assets.each do |asset|
      asset.items.each do |item|
        used_items.each do |used_item|
          if item.package_item == used_item.package_item
            item.increment!(:used_quantity, 1)
            item.logs.create! store_id: @order.store_id,
                              store_chain_id: @order.store_chain_id,
                              store_customer_id: @order.store_customer_id,
                              store_vehicle_id: @order.store_vehicle_id,
                              store_order_id: @order.id,
                              store_order_item_id: used_item.id,
                              latest: 1,
                              quantity: 1,
                              balance: item.left_quantity
            break
          end
        end
      end
    end
  end

end
