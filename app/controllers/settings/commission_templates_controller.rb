class Settings::CommissionTemplatesController < Settings::BaseController
  def index

    @templates = [
      {
        name: 'dslfkj',
        mode_id: 0,
        confined_to: 0,
        status: 0,
        sections: [
          {
            mode_id: 0,
            type_id: 0,
            source_id: 0,
            amount: 2.2
          }
        ]

      }

    ]


    respond_to do |format|
      format.json {
        render json: @templates
      }

      format.html {}
    end
  end
end
