require 'securerandom'

module Mis::Utils
  module Random
    class << self
      def text
        SecureRandom.hex(10)
      end
    end
  end
end
