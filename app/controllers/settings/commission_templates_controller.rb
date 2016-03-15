class Settings::CommissionTemplatesController < Settings::BaseController
  def index

    @templates = current_store.store_commission_templates


    respond_to do |format|
      format.json {
        render json: @templates, root: false
      }

      format.html {}
    end
  end

  def create
    ct = StoreCommissionTemplate.new(template_params)
    ct.store_staff_id = current_user.id
    ct.sections.each do |section|
      section.store_staff_id = ct.store_staff_id
    end
    ct.save
    render json: ct, root: false
  end

  def update
    ct = StoreCommissionTemplate.find(params[:id])
    ct.update(template_params)
    render json: ct, root: false
  end

  private

  def template_params
    safe_params = params.permit(:aim_to, :confined_to, :mode_id, :name, :status, :sharing_enabled,
                    sections_attributes: [:mode_id, :type_id, :source_id, :min, :max, :amount, :id, :_destroy])
    safe_params[:sections_attributes].each do |section|
      if section[:store_staff_id].blank?
        section[:store_staff_id] = current_user.id
      end
    end
    safe_params[:level_weight_hash] = params[:level_weight]
    safe_params
  end
end
