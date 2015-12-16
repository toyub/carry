class EventType

  attr_reader :id, :name, :type
  ID_TYPES={0=>'StoreAttendence', 1=>'StoreReward', 2=>'StorePenalty', 3=>'StoreOvertime'}
  TYPES_ID = ID_TYPES.invert
  TYPES_ARRAY = {
    StoreAttendence: {
      0=>"调休",
      1=>"事假",
      2=>"病假",
      3=>"婚假",
      4=>"丧假",
      5=>"公休假",
      6=>"迟到",
      7=>"早退",
      8=>"矿工",
    },

    StoreReward: {
      0=>"工作优异",
      1=>"拾金不昧",
      2=>"助人为乐",
      3=>"力挽狂澜",
    },

    StorePenalty: {
      0=>"违纪",
      1=>"责任过失",
    },

    StoreOvertime: {
      1=>"项目加班",
      2=>"调休加班",
    }
  }

  def initialize(_id, _name, _type)
    @id=_id
    @name=_name
    @type=_type
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

  def self.collection(type)
    TYPES_ARRAY[type].map do |id, name|
      self.new(id, name, type)
    end
  end
end
