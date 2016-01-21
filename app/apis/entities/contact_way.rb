module Entities
  class ContactWay < Grape::Entity
    expose(:code) { |contact_way, options| contact_way.first }
    expose(:name) { |contact_way, options| contact_way.last }
  end
end
