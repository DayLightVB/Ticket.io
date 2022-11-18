# frozen_string_literal: true

module Stripes
  class UpdateOrderStripe
    def initialize(order)
      @order = order
    end

    def call
      update_order
    end

    private

    def update_order
      @order.update(stripe_product_id: create_stripe_order.id, stripe_price_id: create_stripe_price.id)
    end

    def create_stripe_order
      Stripe::Product.create(name: @order.title)
    end

    def create_stripe_price
      Stripe::Price.create(product: create_stripe_order, unit_amount: @order.total_amount,
                           currency: @order.order_currency)
    end
  end
end
