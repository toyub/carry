class StoreAccountReceivableReport < StoreAccountReport

  def object_name
    if account.property == "集团客户"
      account.company
    else
      account.full_name
    end
  end
end
