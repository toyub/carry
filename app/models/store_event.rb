class StoreEvent < ActiveRecord::Base
  belongs_to :store_staff

  scope :by_type, ->(type) { where("type = ?", type) if type.present? && type != "0"}
  scope :by_date, ->(from, to) { where("created_at >= :start_date AND created_at <= :end_date",
                                       {:start_date => from, :end_date => to}) if from.present? && to.present? }

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
    ],

    StoreOvertime: [
      ["项目加班"],
      ["调休加班"],
    ]
  }

end
