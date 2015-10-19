class Settings::CommissionTemplatesController < Settings::BaseController
  def index

    @templates = 15.times.map do |i|
      mode_id = rand(3)
      aim_to = rand(2)
      confined_to = rand(1)

      {
        name: 'dslfkj'+i.to_s,
        mode_id: mode_id,
        aim_to: aim_to,
        confined_to: confined_to,
        status: 0,
        sections: [
          {
            mode_id: mode_id,
            type_id: 0,
            source_id: 0,
            amount: 2.2
          }
        ]

      }
    end


    respond_to do |format|
      format.json {
        render json: @templates, root: false
      }

      format.html {}
    end
  end
end
