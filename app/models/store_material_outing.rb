class StoreMaterialOuting
  def initialize(params)
    @requester_id = params[:requester_id]
    @outing_type_id = params[:outing_type_id]
    @remark = params[:remark]

    @items = params[:outings].map do |item|
      StoreMaterialOutingItem.new(item)
    end
  end

  def as_json(a, *b, **c, &block)
    {
      requester_id: @requester_id,
      outing_type_id: @outing_type_id,
      remark: @remark,
      items: @items.map { |item|  item.as_json(0) }
    }
  end
end