class UploadSerializer < ActiveModel::Serializer
  attributes :img_url

  def img_url
    object.img
  end
end
