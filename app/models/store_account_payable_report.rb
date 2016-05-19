class StoreAccountPayableReport < StoreAccountReport

  def object_name
    account.name
  end
end
