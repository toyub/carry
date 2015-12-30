class StoreTiaoXin < StoreProtocol
  def increment
    new_salary.to_f - previous_salary.to_f
  end
end
