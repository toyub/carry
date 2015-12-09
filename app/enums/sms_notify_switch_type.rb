class SmsNotifySwitchType
  attr_reader :id, :name
  ID_TYPES={
    0=>'储值套餐购买提醒',
    1=>'储值套餐消费提醒',
    2=>'储值套餐退卡提醒',
    3=>'储值套餐逾期提醒',
    4=>'客户消费提醒',
    5=>'施工流程提醒'
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
