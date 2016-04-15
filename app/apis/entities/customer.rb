module Entities
  class CustomerTags < Grape::Entity
    expose :name
  end

  class Customer < Grape::Entity
    expose :telephone, :full_name, :category, :property
    expose :id, :vehicle_count, :consume_times, :consume_total, :has_customer_asset, if: {type: :default}
    expose(:integrity, if: {type: :default}) {|model| model.integrity.to_s}
    expose(:activeness, if: {type: :default}) {|model| model.activeness.to_s}
    expose(:satisfaction, if: {type: :default}) {|model| model.satisfaction.to_s}
    expose(:store_name, if: {type: :default}) {|model| model.store.name}
    expose(:creator, if: {type: :default}) {|model| model.creator.full_name}
    expose(:points, if: {type: :default}) {|model| model.store_customer_entity.try(:points)}

    expose :nick, :phone_number, :qq, :resident_id, :company, :age,
          :tracking_accepted, :message_accepted, :income,
          :education, :credit, :notice_period, :payment_mode, :invoice_type,
          :range, :address, :remark, :bank, :bank_account,
          :invoice_title, :tax, :contract, :credit_limit, if: {type: :full}
    expose(:gender, if: {type: :full}) {|model| model.gender ? "男" : "女"}
    expose(:married, if: {type: :full}) {|model| model.married ? "已婚" : "未婚"}
    expose(:profession, if: {type: :full}) {|model| model.profession_name}
    expose(:created_at, if: {type: :full}) {|model| model.created_at.strftime("%Y-%m-%d")}
    expose(:birthday, if: {type: :full}) {|model| model.birthday.to_s}
    expose(:province, if: {type: :full}) {|model| model.district['province']}
    expose(:city, if: {type: :full}) {|model| model.district['city']}
    expose(:region, if: {type: :full}) {|model| model.district['region']}
    expose :tags, using: CustomerTags, if: {type: :full}

    expose :entity, using: StoreCustomerEntityInfo, if: {type: :full}

    private
    def entity
      object.store_customer_entity
    end

    def bank
      object.store_customer_entity.try(:store_customer_settlement).try(:bank)
    end

    def bank_account
      object.store_customer_entity.try(:store_customer_settlement).try(:bank_account)
    end

    def invoice_title
      object.store_customer_entity.try(:store_customer_settlement).try(:invoice_title)
    end

    def tax
      object.store_customer_entity.try(:store_customer_settlement).try(:tax)
    end

    def contract
      object.store_customer_entity.try(:store_customer_settlement).try(:contract)
    end

    def credit_limit
      object.store_customer_entity.try(:store_customer_settlement).try(:credit_limit)
    end

    def range
      object.store_customer_entity.try(:range)
    end

    def address
      object.store_customer_entity.try(:address)
    end

    def remark
      object.store_customer_entity.try(:remark)
    end

    def education
      object.education_i18n
    end

    def income
      object.income_i18n
    end
  end
end
