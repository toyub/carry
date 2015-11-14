require 'securerandom'

module Mis::Utils
  module Random
    class << self
      def text
        SecureRandom.hex
      end
    end
  end
end
