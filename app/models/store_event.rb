class StoreEvent < ActiveRecord::Base
  belongs_to :store_staff

  SORT = {
    StoreAttendence: [
      ["调休"],
      ["事假"],
      ["病假"],
      ["婚假"],
      ["丧假"],
      ["公休假"],
      ["迟到"],
      ["早退"],
      ["矿工"],
    ],

    StoreReward: [
      ["工作优异"],
      ["拾金不昧"],
      ["助人为乐"],
      ["力挽狂澜"],
    ],

    StorePenalty: [
      ["违纪"],
      ["责任过失"],
    ]
  }

end
