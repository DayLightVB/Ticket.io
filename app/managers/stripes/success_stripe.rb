# frozen_string_literal: true

module Stripes
  class SuccessStripe
    def initialize(session_with_expand)
      @session_with_expand = session_with_expand
    end

    def call
      expand_session
      create_ticket
      change_event_count
      send_ticket
    end

    private

    def expand_session
      @session_with_expand.line_items.data.each do |line_item|
        all_item(line_item)
      end
    end

    def all_item(line_item)
      @stripe_price = line_item['price']['id']
    end

    def order
      @order ||= Order.find_by(stripe_price_id: @stripe_price)
    end

    def create_ticket
      @ticket = Ticket.create!(event_id: order.event.id, order_id: order.id, user_id: order.user.id,
                               price: @session_with_expand.amount_total, uuid: SecureRandom.uuid, ticket_currency: @session_with_expand.currency)
      order.update(ticket_id: @ticket.id, expiring_at: nil)
    end

    def change_event_count
      order.event.increment!(:sales_count)
      order.event.decrement!(:event_entry_tickets)
    end

    def send_ticket
      NotificationMailer.success_ticket_payment(order.user, @ticket).deliver
    end
  end
end
