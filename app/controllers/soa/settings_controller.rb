class Soa::SettingsController < Soa::BaseController

  def show
    @store = current_store
    @staff = @store.store_staff.find(params[:staff_id])
  end

  def edit
    @store = current_store
    @staff = @store.store_staff.find(params[:staff_id])
    @verifiers = StoreStaff.where(mis_login_enabled: true)
  end

  def new
    @store = current_store
    @staff = @store.store_staff.find(params[:staff_id])
    @verifiers = StoreStaff.where(mis_login_enabled: true)
  end

  def update
    @store = current_store
    @staff = @store.store_staff.find(params[:staff_id])
    params[:store_staff][:skills][:other_skills].reject!(&:empty?)

    if @staff.update!(setting_staff_param)
      redirect_to soa_staff_setting_path(@staff)
    else
      render plain: @staff.errors.messages
    end
  end

  def adjust
    @store = current_store
    @staff = @store.store_staff.find(params[:id])
    @staff.trial_status == "试用中" ? @staff.update(trial_salary: params[:reset_salary]) : @staff.update(regular_salary: params[:reset_salary]) if params[:reset_salary]
    type = params[:protocols][:type]
    params[:protocols][:new_salary] = params[:reset_salary]

    @protocol = @staff.store_protocols.create(protocol_param)

    respond_to do |format|
      if @protocol
        format.html { render plain: @protocol.reason_for }
        format.js
      else
        render plain: "some errors occur!!!"
      end
    end
  end

  private
  def setting_staff_param
    params.require(:store_staff).permit(:trial_salary, :trial_period, :regular_salary, :mis_login_enabled, :app_login_enabled, :deduct_enabled,
                                       :contract_notice_enabled, :deadline_days,
                                       bonus: [:gangwei, :zhusu, :canfei, :laobao, :gaowen, :yibaofei, :baoxianjing, :gerendanbao, :insurence_enabled ],
                                       skills: [:theory, :operate, :integrate, :certificate, :other_skills => [] ]
                                       )
  end
  def protocol_param
    params.require(:protocols).permit(:type, :reason, :previous_salary, :new_salary, :effected_on, :expired_on, :verifier_id, :remark, :created_by, :record_at)
  end
end
