class EventsController < ApplicationController
  before_filter :require_event_owner, only: [:edit, :update]

  def index
    @events = current_user.is_admin ? Event.includes(:user).page(params[:page]).per(25) : current_user.group_events(params)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.new event_params
    @event.group_id = current_user.group_id
    @event.save
  end

  def update
    @event.update_attributes event_params
  end

  private
    def require_event_owner
      @event = current_user.events.find_by_id params[:id]
      redirect_to root_path, alert: "Access denied" if @event.user_id != current_user.id
    end

    def event_params
      params.require(:event).permit(:name, :description, :date, :total_cost)
    end
end