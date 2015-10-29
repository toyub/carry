class StoreCommissionTemplate < ActiveRecord::Base
  include BaseModel

  has_many :sections, class_name: 'StoreCommissionTemplateSection'

  accepts_nested_attributes_for :sections, allow_destroy: true

  def level_weight
    if self.level_weight_hash.present?
      JSON.parse(self.level_weight_hash)
    else
      {}
    end
  end
end
