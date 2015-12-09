class StoreCommissionTemplateSectionSerializer < ActiveModel::Serializer
  attributes :id, :store_id, :store_chain_id, :store_staff_id, :store_commission_template_id,
             :mode_id, :mode_type, :type_id, :method_type, :source_id, :source_type,
             :min, :max, :amount, :created_at, :updated_at
end
