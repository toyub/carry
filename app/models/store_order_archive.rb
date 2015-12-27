class StoreOrderArchive
  def initialize(payments_hash, order)
    @payments_hash = payments_hash
    @order = order
    @customer = order.store_customer
  end

  def reform
      save_payments
      save_deposit_cards
      save_package_services
      save_taozhuang
      pay_finish
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

        @customer.store_customer_entity.increase_balance!(card.denomination)
     end
  end

  def save_package_services
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
                                                                 assetable: package_item,
                                                                 total_quantity: package_item.quantity,
                                                                 workflowable_hash: package_item.package_itemable.to_workflowable_hash
                                                               }
                                                  end
          StoreCustomerPackagedService.create! store_id: @order.store_id,
                                           store_chain_id: @order.store_chain_id,
                                           store_customer_id: @order.store_customer_id,
                                           store_vehicle_id: @order.store_vehicle_id,
                                           items_attributes: items_attributes
        end
       end
    end
  end

  def save_taozhuang
    @order.taozhuangs.each do |order_item|
      if order_item.orderable.service_needed
        order_item.quantity.times do
          items_attributes = order_item.orderable.services.map do |taozhuang_item|
                                                        {store_id: @order.store_id,
                                                         store_chain_id: @order.store_chain_id,
                                                         store_customer_id: @order.store_customer_id,
                                                         assetable: taozhuang_item,
                                                         total_quantity: taozhuang_item.quantity,
                                                         workflowable_hash: taozhuang_item.as_json
                                                       }
                                                  end
          StoreCustomerTaozhuang.create! store_id: @order.store_id,
                                           store_chain_id: @order.store_chain_id,
                                           store_customer_id: @order.store_customer_id,
                                           store_vehicle_id: @order.store_vehicle_id,
                                           items_attributes: items_attributes
        end
      end
    end
  end

  def pay_finish
    if @order.payments.any?(&->(pi){pi.hanging?})
      @order.pay_hanging!
    else
      @order.pay_finished!
    end

    if @order.task_finished?
      @order.finished!
    end
    true
  end

end
