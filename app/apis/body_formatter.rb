module BodyFormatter
  def self.call(object, env)

    return object.to_json if object.is_a?(Hash) and object.has_key?(:swaggerVersion)

    result = { status: 1 }

    result[:data] = object

    if object.is_a?(Hash) && object.has_key?(:data)
      result[:data] = object[:data]
      result[:ext] = %i[total_pages page per_page].reduce({}){|l,n| l[n] = object[n] if object.has_key?(n); l } || {}
    end

    # 去除nil值
    result[:data].try(:compact!)

    result[:data] = {} if result[:data].nil? || result[:data] == true

    result.to_json

  end
end
