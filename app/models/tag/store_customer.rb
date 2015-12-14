class Tag::StoreCustomer < Tag::Base
  def add(taggable)
    self.taggings.create(taggable: taggable)
  end

  def remove(taggable)
    self.taggings.find_by(taggable: taggable).try(:destroy)
  end
end
