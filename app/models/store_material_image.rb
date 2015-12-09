class StoreMaterialImage < StoreAttachment
  belongs_to :store_material, foreign_key: 'host_id'

  def asset_path
    ['', 'attachments', 'materials', self.host_id, 'images', self.file_name].join('/')
  end
end
