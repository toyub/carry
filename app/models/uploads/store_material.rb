class Upload::StoreMaterial < Upload::Base
  mount_base64_uploader :img, StoreMaterialUploader
end
