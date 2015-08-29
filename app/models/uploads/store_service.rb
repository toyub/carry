class Upload::StoreService < Upload::Base
  mount_base64_uploader :img, StoreServiceUploader
end
