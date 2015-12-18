class SmsTrackingSwitchType
  attr_reader :id, :name
  ID_TYPES={
    0=>'服务售后回访',
    1=>'商品售后回访',
    2=>'套餐售后回访'
  }
  TYPES_ID = ID_TYPES.invert

  def initialize(_id, _name)
    @id=_id
    @name=_name
  end

  def self.find(id)
    if ID_TYPES[id]
      self.new(id, ID_TYPES[id])
    else
      nil
    end
  end

  def self.find_by_name(name)
    if TYPES_ID[name]
      self.new(TYPES_ID[name], name)
    else
      nil
    end
  end

  def self.name_in(names)
    ID_TYPES.find_all(&->(key,val){names.include?(val)}).map(&->(tipe){self.new(*tipe) })
  end

  def self.collection
    ID_TYPES.map{|key, value| self.new(key, value)}
  end
end
