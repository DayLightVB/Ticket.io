module Stripes
  class ExpiredStripe

    def call
      expiring
    end

    private

    def expired_orders
      Order.where('expiring_at < ?', Time.now).where('session_id is not null')
    end

    def expiring
      expired_orders.each do |order|
        Stripe::Checkout::Session.expire(order.session_id)
      rescue
        # To do
      ensure
        order.update(expiring_at: nil)
      end
    end
  end
end
