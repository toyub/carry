class StoreMaterialOutingItem
  def initialize(params)
    @params = params
  end
  
  def as_json(a, *b, **c, &d)
    @params
  end
end