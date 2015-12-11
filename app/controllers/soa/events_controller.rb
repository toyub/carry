class Soa::EventsController < Soa::BaseController
  def index
    @staffs = current_store.store_staff
                                              # .by_keyword(params[:keyword])
                                              # .by_level(params[:level_type_id])
                                              # .by_job_type(params[:job_type_id])
  end

  def new
    @staff = current_store.store_staff.find(params[:id])
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
      redirect_to soa_event_path(id: @staff)
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
    params.require(:store_event).permit(:type, :sort, :start_on, :end_on, :occur_on,
                                        :occur_at, :description, :recorder_id,
                                        operate: [:amount, :other]
                                       )
  end

end
