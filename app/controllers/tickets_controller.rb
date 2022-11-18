# frozen_string_literal: true

class TicketsController < ApplicationController
  before_action :correct_user, only: [:show]
  before_action :authenticate_user!
  after_action :validation, only: [:show]

  def index
    @tickets = current_user.tickets.all.order(created_at: :desc).page(params[:page]).per(3)
  end

  def show
    @ticket = Ticket.find_by_uuid(params[:id]) || Ticket.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: @ticket.id.to_s, template: 'tickets/ticket.html.haml'
      end
    end
  end

  private

  def validation
    @ticket.update(status: 'scanned') if current_user.has_role?(:gatekeeper) && @ticket.status == 'available'
    @ticket.increment!(:fraud_attempts) if @ticket.status == 'scanned' && current_user.has_role?(:gatekeeper)
  end

  def correct_user
    if !current_user.nil? && current_user.has_role?(:gatekeeper)
      @ticket = Ticket.find_by_uuid(params[:id])
    elsif !current_user.nil?
      @ticket = current_user.tickets.find_by(id: params[:id]) || current_user.tickets.find_by_uuid(params[:id])
      redirect_to events_path, notice: 'Ticket is unavailable or this ticket is not your' if @ticket.nil?
    elsif @ticket.nil?
      redirect_to events_path, notice: 'Ticket is unavailable or this ticket is not your'
    end
  end

  def ticket_params
    params.require(:ticket).permit(:event_id, :user_id, :price, :payment_id, :uuid)
  end
end
