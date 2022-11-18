# frozen_string_literal: true

class OrdersController < ApplicationController
  def create
    manager = Orders::CreateManager.new(current_user, event, promo_code_value)
    manager.call
    redirect_to(event, alert: 'No tickets, try again later') && return unless manager.available_order?
    redirect_to(event, alert: t('promocode.currency.error')) && return unless manager.promo_code_acceptable_currency?

    if manager.order.promo_code_id && manager.order.total_amount.negative?
      redirect_to(manager.ticket, notice: t('success_bought_ticket_via_promo_code'))
    else
      redirect_to checkout_create_path(id: manager.order.id)
    end
  end

  private

  def event
    @event ||= Event.find(params[:event_id])
  end

  def promo_code
    @promo_code ||= PromoCode.find_by(uuid: promo_code_value)
  end

  def promo_code_value
    params.dig(:order, :promo_code_id)
  end

  def order_params
    params.require(:order).permit(:order, :promo_code_id)
  end
end
