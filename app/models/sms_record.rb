class SmsRecord < ActiveRecord::Base
  belongs_to :party, polymorphic: true
end
