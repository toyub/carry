#商品拆分销售时选择的单位，用户不能自定义
class MaterialDivideUnitType
  attr_reader :id, :name
  ID_TYPES={ 0 => '米', 1 => '平方米', 2 => '升'}
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