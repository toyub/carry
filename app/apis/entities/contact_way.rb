module Entities
  class ContactWay < Grape::Entity
    expose :code do |contact_way, options|
      contact_way.first
    end
    expose :name do |contact_way, options|
      contact_way.last
    end
  end
end
