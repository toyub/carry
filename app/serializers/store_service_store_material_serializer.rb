class StoreServiceStoreMaterialSerializer < ActiveModel::Serializer
  attributes :mode, :name, :store_material_id

  def mode
    "领用"
  end

  def name
    object.store_material.name
  end
end
