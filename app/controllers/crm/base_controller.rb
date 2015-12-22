module Crm
  class BaseController < ApplicationController
    before_filter :login_required

    respond_to :json

    private

    def default_serializer_options
      {root: false}
    end


    ## add store_attrs to params
    def append_store_attrs options
      nested_attrs = options.select(&nested_selector).transform_values(&nested_transformer)
      options.merge(store_options).merge(nested_attrs)
    end

    def store_options
      {store_staff_id: current_staff.id, store_id: current_store.id, store_customer_id: @customer.id}
    end

    def nested_transformer
      -> (v) do
        case v
        when Array
          v.map { |x| x.merge(store_options) }
        when Hash
          v.values.first.is_a?(Hash) ? v.values.map { |x| x.merge(store_options) } : v.merge(store_options)
        end
      end
    end

    def nested_selector
      -> (k, v) { k.end_with?('_attributes') }
    end
  end
end
