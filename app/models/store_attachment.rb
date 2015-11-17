class StoreAttachment < ActiveRecord::Base
  validates :file_name, :file_size, :content_type, presence: true

  def initialize(*args, &block)
    raise NotImplementedError, "#{self.class} is an abstract class and cannot be instantiated." if self.class == StoreAttachment
    super
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
