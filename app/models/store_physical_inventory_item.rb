class StorePhysicalInventoryItem < ActiveRecord::Base
  include BaseModel
  belongs_to :store_material
  scope :status_is, ->(stat){
    if stat.present?
      where(status: stat)
    end
  }

  scope :diff_is, ->(diff){
    if diff.present?
      if diff.to_i == 1
        where('diff > 0')
      elsif diff.to_i == -1
        where('diff < 0')
      end
    end
  }
end
