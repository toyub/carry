class ServiceMechanicLevelType
  attr_reader :id, :name
  ID_TYPES={0=>'初级以上(含初级)', 1=>'中级以上(含中级)', 2=>'高级以上(含高级)', 3=>'专家'}
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
