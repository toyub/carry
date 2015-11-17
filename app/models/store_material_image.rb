class StoreMaterialImage < StoreAttachment
  belongs_to :store_material, foreign_key: 'host_id'

  def asset_path
    ['', 'attachments', 'materials', self.host_id, 'images', self.file_name].join('/')
  end
end

# == Schema Information
#
# Table name: store_attachments
#
#  id           :integer          not null, primary key
#  type         :string(45)       not null
#  host_id      :integer          not null
#  file_name    :string(45)       not null
#  file_size    :integer          not null
#  content_type :string(45)       not null
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  type_of_attachments  (type,host_id)
#
