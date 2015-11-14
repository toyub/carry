class Upload::StorePackage < Upload::Base
  mount_base64_uploader :img, StorePackageUploader
end
