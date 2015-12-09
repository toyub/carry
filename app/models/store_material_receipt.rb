class StoreMaterialReceipt < ActiveRecord::Base
  belongs_to :store_staff

  include BaseModel

  before_save :set_numero

  def set_numero
    self.numero = ApplicationController.helpers.make_numero('IN')
  end
end
