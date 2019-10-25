class EventsController < ApplicationController
  def index
    if params[:e] == 'my-events'
      @events = Event.where(user: current_user)
    else
      @events = Event.all
    end

    @calendar_events = @events.flat_map do |e|
      e.calendar_events(params.fetch(:start_date, Time.zone.now).to_date)
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user

    if @event.save
      redirect_to @event
    else
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
    if current_user.id != @event.user.id
      redirect_to events_url, alert: 'This is not your event'
    end
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event
    else
      redner 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_path
  end

  private
  def event_params
    params.require(:event).permit(:title, :start_time, :recurring)
  end
end
