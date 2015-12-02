class Soa::SettingController < Soa::ControllerBase

  def show
    @store = current_store
    @staff = @store.store_staff.find(params[:id])
    @disable = true
    @action_uri = edit_soa_setting_path
    @method = :get
  end

  def edit
    @store = current_store
    @staff = @store.store_staff.find(params[:id])
    @disable = false
    @action_uri = soa_setting_path
    @method = :patch
  end

  def new
    @store = current_store
    @staff = @store.store_staff.find(params[:id])
    @disable = false
    @staff.bonus ||= {}
    @staff.skills ||= {}
    @staff.other ||= {}
    @action_uri = soa_setting_path
    @method = :patch
  end

  def update
    @store = current_store
    @staff = @store.store_staff.find(params[:id])

    if @staff.update(setting_staff_param)
      redirect_to soa_staff_index_path
    else
      render :show, notice: "something errors"
    end
  end

  private
  def setting_staff_param
    params.require(:store_staff).permit(:trial_salary, :trial_period, :regular_salary,
                                       bonus: [:gangwei, :zhusu, :canfei, :laobao, :gaowen, :yibaofei, :baoxianjing, :gerendanbao ],
                                       skills: [:theory, :operate, :integrate, :certificate, :other_skills => [] ],
                                       other: [:deduct, :system_operator, :can_use_app]
                                       )
  end
end
