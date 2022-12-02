# frozen_string_literal: true

class Api::EventsController < ApplicationController
  before_action :set_event, only: %i[show update destroy]
  before_action :authenticate_user!, except: %i[show index create edit update destroy]
  skip_before_action :verify_authenticity_token


  def index
    @events = Event.all
    render json: @events
  end

  def show
    render json: @event
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      render json: @event, status: :ok
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
  end

  private

  def set_event
    @event = Event.find(params[:id])
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
