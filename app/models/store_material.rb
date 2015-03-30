class StoreMaterial < ActiveRecord::Base
  belongs_to :store
  belongs_to :store_chain
  belongs_to :store_material_unit
  belongs_to :store_material_brand
  belongs_to :store_material_category
  belongs_to :store_material_manufacturer
  belongs_to :creator, class_name: 'Staff', foreign_key: 'store_staff_id'

  has_many :store_material_images, foreign_key: 'host_id'

  after_save :generate_barcode!

  private
  def generate_barcode!
    unless self.barcode.present?
      self.barcode = format('N%s%s', self.store_id.to_s(36).upcase.rjust(5, '0'), self.id.to_s(36).upcase.rjust(5, '0'))
      self.save
    end
  end
end
