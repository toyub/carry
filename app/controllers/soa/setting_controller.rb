class Soa::SettingController < Soa::ControllerBase

  def show
    @store = current_store
    @staff = @store.store_staff.find(params[:id])
    @disable = true
    @action_uri = edit_soa_setting_path
    @method = :get

    @textvalue = get_second_form_textvalue(@staff, "StoreZhuanZheng")
    @textvalue.merge! get_second_form_textvalue(@staff, "StoreTiaoXin")
    @textvalue.merge! get_second_form_textvalue(@staff, "StoreQianDingHeTong")
  end

  def edit
    @store = current_store
    @staff = @store.store_staff.find(params[:id])
    @disable = false
    @action_uri = soa_setting_path
    @method = :patch

    @textvalue = get_second_form_textvalue(@staff, "StoreZhuanZheng")
    @textvalue.merge! get_second_form_textvalue(@staff, "StoreTiaoXin")
    @textvalue.merge! get_second_form_textvalue(@staff, "StoreQianDingHeTong")
  end

  def new
    @store = current_store
    @staff = @store.store_staff.find(params[:id])
    @disable = false
    @staff.bonus ||= {}
    @staff.skills ||= {}
    @staff.other ||= {}
    @action_uri = soa_setting_path(id: params[:id])
    @method = :patch

    @textvalue = {"StoreZhuanZheng": {}, "StoreTiaoXin": {}, "StoreQianDingHeTong": {}}
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

  def adjust

    @store = current_store
    @staff = @store.store_staff.find(params[:id])
    type = params[:protocols][:type]

    if StoreProtocol.is_new_record?(type)
      @protocol = @staff.store_protocols.create(protocol_param)
    else
      @protocol = @staff.store_protocols.operate_type(type)[0].update(protocol_param)
    end

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
    params.require(:store_staff).permit(:trial_salary, :trial_period, :regular_salary,
                                       bonus: [:gangwei, :zhusu, :canfei, :laobao, :gaowen, :yibaofei, :baoxianjing, :gerendanbao ],
                                       skills: [:theory, :operate, :integrate, :certificate, :other_skills => [] ],
                                       other: [:deduct, :system_operator, :can_use_app]
                                       )
  end
  def protocol_param
    params.require(:protocols).permit(:type, :reason_for, :effective_date, :end_at, :verifier_id, :remarks, :created_by, :record_at)
  end
end
