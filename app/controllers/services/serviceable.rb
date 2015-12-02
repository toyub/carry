module Serviceable
  def self.included(base)
    base.send(:extend, ClassMethods)
	end

  module ClassMethods
    def call(*args)
      new(*args).call
    end
  end

  def call
    raise "call method must be implemented"
  end
end
