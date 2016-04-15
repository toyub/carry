class Soa::SettingsController < Soa::BaseController

  def show
    @store = current_store
    @staff = @store.store_staff.find(params[:staff_id])
  end

  def edit
    @store = current_store
    @staff = @store.store_staff.find(params[:staff_id])
    @verifiers = @store.store_staff.verifiers
  end

  def new
    @store = current_store
    @staff = @store.store_staff.find(params[:staff_id])
    @verifiers = @store.store_staff.verifiers
  end

  def update
    @store = current_store
    @staff = @store.store_staff.find(params[:staff_id])
    params[:store_staff]["skills"]["other_skills"].reject!(&:empty?)
    @staff.update!(regular: false) if params[:store_staff][:trial_salary].present?

    if @staff.update!(setting_staff_param)
      redirect_to soa_staff_setting_path(@staff)
    else
      render plain: @staff.errors.messages
    end
  end

  def adjust
    @store = current_store
    @staff = @store.store_staff.find(params[:staff_id])
    @staff.transaction {
      @staff.reset_salary(params[:reset_salary]) if params[:reset_salary]
      params[:protocols][:new_salary] = params[:reset_salary]
      @protocol = @staff.store_protocols.create(protocol_param)
    }
    @staff.update!(regular: true) if @staff.could_regular?
    respond_to do |format|
      if @protocol
        format.html { render plain: @protocol.reason_for }
        format.js
      else
        render plain: "some errors occur!!!"
      end
    end
  end


  def password
    @staff = current_store.store_staff.find(params[:staff_id])

    respond_to do |format|
      if @staff.update!(staff_password_param)
        @staff.reset_password!(params[:store_staff][:password], params[:store_staff][:password_confirmation])
        format.js
      else
        format.js { render plain: "some errors occur!!!" }
      end
    end
  end

  private
  def setting_staff_param
    params.require(:store_staff).permit(:trial_salary, :trial_period, :regular_salary, :mis_login_enabled, :app_login_enabled, :erp_login_enabled, :deduct_enabled,
                                       :contract_notice_enabled, :deadline_days,
                                       bonus: [:gangwei, :zhusu, :canfei, :laobao, :gaowen, :yibaofei, :baoxianjing, :gerendanbao, :insurence_enabled ],
                                       skills: [:theory, :operate, :integrate, :certificate, :other_skills => [] ]
                                       )
  end

  def protocol_param
    params.require(:protocols).permit(:type, :reason, :previous_salary, :new_salary, :effected_on, :expired_on, :verifier_id, :remark, :created_by, :record_at)
  end

  def staff_password_param
    params.require(:store_staff).permit(:password, :password_confirmation, :mis_login_enabled, :app_login_enabled, :erp_login_enabled)
  end

end
