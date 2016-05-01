class Envelope < ActiveRecord::Base
  belongs_to :sender, polymorphic: true
  belongs_to :receiver, polymorphic: true
  belongs_to :message, polymorphic: true, counter_cache: true, dependent: :destroy

  before_create :set_extra_type

  private
  def set_extra_type
    self.extra_type = self.message.class.name
  end
end
