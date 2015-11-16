class StoreFile < ActiveRecord::Base
  include BaseModel

  validates :fileable_id, presence: true
  validates :fileable_type, presence: true

  belongs_to :fileable, polymorphic: true

  def file_url
    "#{$qiniu_config[:host]}/#{img}"
  end
end
