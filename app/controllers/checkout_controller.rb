# frozen_string_literal: true

class CheckoutController < ApplicationController
  before_action :expired_stripe, only: [:create]
  def create
    Stripes::UpdateOrderStripe.new(order).call
    @session = Stripe::Checkout::Session.create({
                                                  customer: current_user.stripe_customer_id,
                                                  payment_method_types: ['card'],
                                                  line_items: [{
                                                    price: order.stripe_price_id,
                                                    quantity: 1
                                                  }],
                                                  mode: 'payment',
                                                  success_url: "#{success_url}?session_id={CHECKOUT_SESSION_ID}",
                                                  cancel_url: cancel_url
                                                })
    order.update(session_id: @session.id)
    redirect_to @session.url
  end

  def success
    @session_with_expand = Stripe::Checkout::Session.retrieve({ id: params[:session_id], expand: ['line_items'] })
  end

  def expired_stripe
    Stripes::ExpiredStripe.new.call
  end

  def cancel; end

  private

  def order
    @order ||= Order.find(params[:id])
  end
end
