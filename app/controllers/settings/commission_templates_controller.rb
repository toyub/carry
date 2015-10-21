class Settings::CommissionTemplatesController < Settings::BaseController
  def index

    @templates = StoreCommissionTemplate.all


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
    render json: template_params
  end

  private

  def template_params
    params.permit(:aim_to, :confined_to, :mode_id, :name,
                  sections_attributes: [:mode_id, :type_id, :source_id, :amount, :id, :_destroy])
  end
end
