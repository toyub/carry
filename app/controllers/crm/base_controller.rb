module Crm
  class BaseController < ApplicationController
    before_filter :login_required

    respond_to :json

    private

    def default_serializer_options
      {root: false}
    end

    def append_attrs(target_options, *opts)
      options = opts.inject({}) { |options, option| options.merge option  }
      nested_attrs = target_options.select(&nested_selector).transform_values(&nested_transformer(options))
      target_options.merge(base_options).merge(nested_attrs)
    end

    def store_option
      { store_id: current_store.id }
    end

    def staff_option
      { store_staff_id: current_staff.id }
    end

    def customer_option
      { store_customer_id: @customer.id }
    end

    def base_options
      { store_id: current_store.id, store_staff_id: current_staff.id, store_customer_id: @customer.id }
    end

    def nested_transformer(options)
      -> (v) do
        case v
        when Array
          v.map { |x| x.merge(options) }
        when Hash
          v.values.first.is_a?(Hash) ? v.values.map { |x| x.merge(options) } : v.merge(options)
        end
      end
    end

    def nested_selector
      -> (k, v) { k.to_s.end_with?('_attributes') }
    end
  end
end
