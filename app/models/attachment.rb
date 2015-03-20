class Attachment < ActiveRecord::Base
  validates :file_name, :file_size, :content_type, presence: true

  def initialize(*args, &block)
    raise NotImplementedError, "#{self.class} is an abstract class and cannot be instantiated." if self.class == Attachment
    super
  end
end