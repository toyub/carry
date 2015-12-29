class StoreMaterialSaleinfoServiceSerializer < ActiveModel::Serializer

  attributes :store_material_saleinfo_id, :id, :store_id, :store_chain_id, :store_staff_id, :store_material_id,
             :store_commission_template_id, :name, :mechanic_level, :work_time, :work_time_unit,
             :work_time_in_seconds, :tracking_needed, :tracking_delay, :tracking_delay_unit,
             :tracking_delay_in_seconds, :tracking_contact_way, :tracking_content,
             :created_at, :updated_at, :mechanic_commission_template_id, :quantity, :mechanic_commission_template

  def mechanic_commission_template
    StoreCommissionTemplateSerializer.new(object.mechanic_commission_template).as_json(root:nil)
  end

end
