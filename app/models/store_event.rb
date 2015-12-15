class StoreEvent < ActiveRecord::Base
  belongs_to :store_staff

  scope :by_type, ->(type = DefaultType) { where(type: type) if type.present? && type != "0"}
  scope :by_month, ->(month = CurrentMonth) { where('extract(month from created_at) = ?', month) }
  scope :by_date, ->(from, to) { where("created_at >= :start_date AND created_at <= :end_date",
                                       {:start_date => from, :end_date => to}) if from.present? && to.present? }


  DefaultType = "StoreAttendence"
  CurrentMonth = Time.now.beginning_of_month.strftime("%m")
  class << self

    def total_pay_of_type_per_month(type = DefaultType, month = CurrentMonth )
      sum =  0
      by_month(month).by_type(type).each do |event|
        sum += event.operate["amount"].to_i
      end
      sum
    end

    def quantity_of_type_per_month(type = DefaultType, month = CurrentMonth )
      by_month(month).by_type(type).count
    end

    def total_pay(month = CurrentMonth)
      sum = 0
      sum = total_pay_of_type_per_month("StoreReward", month) + total_pay_of_type_per_month("StoreOvertime") -
        total_pay_of_type_per_month("StorePenalty") - total_pay_of_type_per_month("StoreAttendence")
      sum
    end

  end

  def recorder
    StoreStaff.find(recorder_id).screen_name
  end

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
