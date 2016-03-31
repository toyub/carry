module V1
  class StoreOrders < Grape::API
    before do
      authenticate_platform!
      authenticate_user!
    end

    resource :store_orders, desc: "订单相关" do
      add_desc "订单提交(确认订单)"
      params do
        requires :platform, type: String, desc: '验证平台！'
        requires :store_customer_id, type: Integer, desc: '客户id'
        requires :vehicle_id, type: Integer, desc: '车辆的id'
        optional :plate_id, type: Integer, desc: '车牌的id'
        optional :items_attributes, type: Array do
          optional :orderable_id, type: Integer, desc: '选择的对应id,如果套餐服务，则需要从套餐接口获取对应的package_itemable_id'
          optional :orderable_type, type: String, desc: '服务：StoreService,商品:StoreMaterialSaleinfo, 套餐: StorePackage,
                                                         商品服务： StoreMaterialSaleinfoService, 套餐服务: 套餐接口获取package_itemable_type'
          optional :quantity, type: Integer, desc: '数量'
          optional :retail_price, type: BigDecimal, desc: '销售单价'
          optional :vip_price, type: BigDecimal, desc: '会员价'
          optional :discount, type: BigDecimal, desc: '优惠价'
          optional :discount_reason, type: String, desc: '优惠理由'
          optional :price, type: BigDecimal, desc: '单价'
          optional :from_customer_asset, type: Boolean, desc: '是否卡扣'
          optional :store_customer_asset_item_id, type: Integer, desc: '卡扣的id'
          optional :package_type, type: String, desc: '商品服务情况下：StoreMaterialSaleinfo，
                                                       套餐服务情况下：StorePackage,其他情况可不填！'
          optional :package_id, type: Integer, desc: '商品服务情况下： store_material_saleinfo_id，
                                                      套餐服务情况下： store_package_id,其他情况可不填!'
          optional :assetable_type, type: String, desc: '商品服务情况下: StoreMaterialSaleinfoService
                                                         套餐服务情况下: 同orderable一样,其他情况可不填!'
          optional :assetable_id, type: Integer, desc: '商品服务情况下: store_material_saleinfo_service_id,
                                                        套餐服务情况下: 同orderable一样,其他情况可不填!'
          optional :package_item_type, type: String, desc: '商品服务情况下: StoreMaterialSaleinfoService,
                                                            套餐服务情况下: StorePackageItem'
          optional :package_item_id, type: Integer, desc: '商品服务情况下: store_material_saleinfo_service_id,
                                                            套餐服务情况下: store_package_item_id'
        end
      end

      add_desc '下单'
      post do
        status = StoreOrderService.call(order_params, basic_params)
        present status: status.success, order_id: status.notice
      end

      route_param :order_id do
        before do
          @order = StoreOrder.find(params[:order_id])
        end
        add_desc '订单更新(订单编辑)'
        params do
          requires :order_id, type: Integer, desc: '订单的id'
          requires :platform, type: String, desc: '验证平台！'
          requires :store_customer_id, type: Integer, desc: '客户id'
          optional :plate_id, type: Integer, desc: '车牌的id'
          optional :items_attributes, type: Array do
            optional :item_id, type: Integer, desc: '更新的item的id'
            optional :orderable_id, type: Integer, desc: '选择的对应id,如果套餐服务，则需要从套餐接口获取对应的package_itemable_id'
            optional :orderable_type, type: String, desc: '服务：StoreService,商品:StoreMaterialSaleinfo, 套餐: StorePackage,
                                                           商品服务： StoreMaterialSaleinfoService, 套餐服务: 套餐接口获取package_itemable_type'
            optional :quantity, type: Integer, desc: '数量'
            optional :retail_price, type: BigDecimal, desc: '销售单价'
            optional :vip_price, type: BigDecimal, desc: '会员价'
            optional :discount, type: BigDecimal, desc: '优惠价'
            optional :discount_reason, type: String, desc: '优惠理由'
            optional :price, type: BigDecimal, desc: '单价'
            optional :from_customer_asset, type: Boolean, desc: '是否卡扣'
            optional :store_customer_asset_item_id, type: Integer, desc: '卡扣的id'
            optional :package_type, type: String, desc: '商品服务情况下：StoreMaterialSaleinfo，
                                                         套餐服务情况下：StorePackage,其他情况可不填！'
            optional :package_id, type: Integer, desc: '商品服务情况下： store_material_saleinfo_id，
                                                        套餐服务情况下： store_package_id,其他情况可不填!'
            optional :assetable_type, type: String, desc: '商品服务情况下: StoreMaterialSaleinfoService
                                                           套餐服务情况下: 同orderable一样,其他情况可不填!'
            optional :assetable_id, type: Integer, desc: '商品服务情况下: store_material_saleinfo_service_id,
                                                          套餐服务情况下: 同orderable一样,其他情况可不填!'
            optional :package_item_type, type: String, desc: '商品服务情况下: StoreMaterialSaleinfoService,
                                                              套餐服务情况下: StorePackageItem'
            optional :package_item_id, type: Integer, desc: '商品服务情况下: store_material_saleinfo_service_id,
                                                              套餐服务情况下: store_package_item_id'
          end
        end
        put  do
          order = StoreOrder.find(params[:order_id])
          status = StoreOrderService.call(order_params, basic_params, order: order)
          present status: status.success, info: status.notice
        end

        add_desc '订单详情'
        params do
          requires :platform, type: String, desc: '验证平台！'
          requires :order_id, type: Integer, desc: '订单的id'
        end
        get do
          present @order, with: ::Entities::StoreOrder, type: :full
        end

      end

      add_desc '订单列表'
      params do
        requires :platform, type: String, desc: '验证平台！'
        requires :service_included, type: Boolean, desc: 'true为需要施工，false为不需要施工'
        optional :q, type: Hash, default: {} do
          optional :plate_license_number_cont, type: String
          optional :store_customer_phone_number_cont, type: String
          optional :state_eq, type: Integer, desc: '订单状态'
          optional :task_status_eq, type: Integer, desc: '订单施工状态'
          optional :pay_status_in, type: Array, desc: '订单付费状态'
        end
      end
      get do
        orders = current_store.store_orders.available.ransack(params[:q]).result
        if params[:service_included]
          orders = orders.has_service.unfinished.unpending
        end
        present orders, with: ::Entities::StoreOrder, type: :default
      end
    end

    helpers do
      def params_permit
        @order = ActionController::Parameters.new(params)
      end

      def basic_params
        params_permit
        params[:store_id] = current_store.id
        params[:store_chain_id] = current_store_chain.id
        params[:store_staff_id] = current_user.id
        @order.permit(:store_id,
                      :store_chain_id,
                      :store_staff_id)
      end

      def order_params
        params_permit
        basic_params
        @order.permit(
          :vehicle_id,
          :plate_id,
          :store_customer_id,
          :store_id,
          :store_chain_id,
          :store_staff_id,
          items_attributes: [
            :item_id,
            :orderable_id,
            :orderable_type,
            :quantity,
            :retail_price,
            :vip_price,
            :discount,
            :discount_reason,
            :price,
            :from_customer_asset,
            :store_customer_asset_item_id,
            :orderable_type,
            :orderable_id,
            :assetable_type,
            :assetable_id,
            :package_id,
            :package_type,
            :package_item_id,
            :package_item_type
          ]
        )
      end
    end

  end
end
