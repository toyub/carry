class StoreSalaryReview
  def initialize(staff)
    @salary = staff.store_salaries.last
    if @salary.try(:created_month) != Time.now.strftime("%Y%m") || @salary.try(:checked?)
      @salary = staff.store_salaries.build(default_salary_params(staff))
    end
  end

  def salary
    @salary
  end

  private
  def default_salary_params(staff)
    {
      amount_deduction: staff.commission_amount_total,
      deduction: {
        shigong: staff.services_commission,
        shangpin: staff.materials_commission,
      },
      amount_overtime: staff.store_overworks.total,
      amount_reward: staff.store_rewards.total,
      bonus: {gangwei: staff.bonus["gangwei"], zhusu: staff.bonus["zhusu"], canfei: staff.bonus["canfei"], laobao: staff.bonus["laobao"], gaowen: staff.bonus["gaowen"] },
      amount_bonus: staff.bonus_amount,
      insurence: {yibaofei: staff.bonus["yibaofei"], baoxianjing: staff.bonus["baoxianjing"]},
      amount_insurence: staff.insurence_amount,
      cutfee: {weiji: staff.store_penalties.total,
               kaoqin: staff.store_attendence.total,
               jiedai: "",
               qita: "",
               gerendanbao: staff.bonus["gerendanbao"] },
      amount_should_cutfee: staff.cutfee,
      amount_cutfee: staff.cutfee,
      salary_should_pay: staff.should_pay,
      salary_actual_pay: staff.should_pay - staff.cutfee
    }
  end
end
