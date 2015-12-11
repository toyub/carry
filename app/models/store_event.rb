class StoreEvent < ActiveRecord::Base
  belongs_to :store_staff

  scope :by_type, ->(type) { where("type = ?", type) if type.present? && type != "0"}
  scope :by_date, ->(from, to) { where("created_at >= :start_date AND created_at <= :end_date",
                                       {:start_date => from, :end_date => to}) if from.present? && to.present? }

  class << self
    def sum_by_type(type = "StoreAttendence")
      sum = 0
      where(type: type).each do |e|
        sum += e.operate["amount"].to_i
      end
      sum
    end

    def current_month
      Time.now.beginning_of_month.strftime("%m")
    end

    def get_per_month_pay(type = "StoreAttendence", month = current_month)
      where('extract(month from created_at) = ?', month).sum_by_type(type)
    end

    def total_pay(month = current_month)
      sum = 0
      sum = get_per_month_pay("StoreReward", month) + get_per_month_pay("StoreOvertime") -
        get_per_month_pay("StorePenalty") - get_per_month_pay("StoreAttendence")
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
