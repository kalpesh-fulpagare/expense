class EventsController < ApplicationController
  before_filter :find_event, only: [:edit, :update, :show, :change_status]
  before_filter :require_event_owner, only: [:edit, :update, :change_status]

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

  def change_status
    @event.update_attribute(:status, params[:status])
    redirect_to events_path, notice: "Successfully changed status of event"
  end

  private
    def require_event_owner
      redirect_to root_path, alert: "Access denied" if @event.user_id != current_user.id
    end

    def event_params
      params[:event][:participant_ids].try(:delete, '')
      params.require(:event).permit(:name, :description, :date, :total_cost, participant_ids: [])
    end
end
