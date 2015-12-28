class Soa::EventsController < Soa::BaseController
  def index
    @staffs = current_store.store_staff
    @departments = current_store.store_departments
    @positions = @departments[0].store_positions
  end

  def search
    @date = Date.today
    if params["date(1i)"] && params["date(2i)"]
      @date = Date.new params["date(1i)"].to_i, params["date(2i)"].to_i, params["date(3i)"].to_i
    end
    @staffs = current_store.store_staff
                                       .by_keyword(params[:keyword])
                                       .by_department_id(params[:store_department_id])
                                       .by_position_id(params[:store_position_id])

    @departments = current_store.store_departments
    if params[:store_department_id].present?
      @positions = @departments.find(params[:store_department_id]).store_positions
    else
      @positions = @departments[0].store_positions
    end
    render 'index'
  end

  def new
    @staff = current_store.store_staff.find(params[:staff_id])
    @event = @staff.store_events.build
  end

  def show
    @staff = current_store.store_staff.find(params[:id])
    @events = @staff.store_events.by_type(params[:type])
                                 .by_date(params[:from], params[:to])
  end

  def create
    @staff = current_store.store_staff.find(params[:staff_id])
    @event = @staff.store_events.build(event_params)

    if @event.save
      redirect_to soa_staff_record_index_path(staff_id: @staff, type: @event.type)
    else
      render plain: @event.errors.messages
    end
  end

  def detail
    @event = StoreEvent.find(params[:id])
    @staff = @event.store_staff
    respond_to do |format|
      format.js
    end
  end

  private

  def event_params
    params.require(:store_event).permit(:type, :sort, :period, :start_on, :end_on, :occur_on,
                                        :occur_at, :description, :recorder_id,
                                        operate: [:amount, :other]
                                       )
  end

end
