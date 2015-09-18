class OutingType
  attr_reader :id, :name
  ID_TYPES={ 0 => '领用出库', 1 => '销售出库', 2 => '赠送出库', 3=> '盘亏出库', 4 => '生产出库', 5 => '转移出库', 6 => '报损出库'}
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

  def self.collection
    ID_TYPES.map{|key, value| self.new(key, value)}
  end
end
