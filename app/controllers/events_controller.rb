class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :event, only: %i[destroy show edit update]
  before_action :fraud, only: %i[index]

  def index
    @events = if params[:tag]
                Event.joins(:tags).merge(Tag.by_name(params[:tag])).page(params[:page]).per(3)
              else
                Event.includes(:tags).order(:title).page(params[:page]).per(3)
              end
    @tags = Tag.all
  end

  def show
    @order = event.orders.new
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: event.id.to_s, template: 'events/event.html.haml'
      end
    end
  end

  def new
    @event = Event.new
    authorize event
  end

  def create
    @event = Event.new(event_params)
    if event.save
      redirect_to event, notice: 'Event was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize event
  end

  def update
    authorize event
    if event.update(event_params)
      current_user.add_role :moderator, event
      redirect_to event, notice: 'Event was successfully created.'
    else
      render :edit
    end
  end

  def destroy
    authorize event
    event.destroy
    redirect_to events_path, notice: 'Event was successfully deleted.'
  end

  def fraud
    @fraud_tries = Event.joins(:tickets)
                        .select('events.*, SUM(tickets.fraud_attempts) AS fraud_attempts_sum')
                        .group('events.id')
                        .sum(:fraud_attempts)
  end

  private

  def event
    @event ||= Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title,
                                  :description,
                                  :start_date,
                                  :price,
                                  :price_cents,
                                  :currency,
                                  :order_id,
                                  :duration,
                                  :event_entry_tickets,
                                  :sales_count,
                                  :order_id,
                                  :avatar,
                                  :tag_list,
                                  :tag,
                                  { tag_ids: [] },
                                  :tag_ids,
                                  images: [])
  end
end
