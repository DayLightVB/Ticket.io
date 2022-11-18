# frozen_string_literal: true

module Orders
  class CreateManager
    STANDART_MIN_AMOUNT = 51
    EUR_MIN_AMOUNT = 51
    USD_MIN_AMOUNT = 51
    PLN_MIN_AMOUNT = 201
    attr_reader :event, :order, :ticket, :promo_code_value

    def initialize(user, event, promo_code_value)
      @user = user
      @event = event
      @promo_code_value = promo_code_value.size > 5 ? promo_code_value : nil
    end

    def call
      check_remaining_orders
      create_order
      process_promocode && promo_code_acceptable_currency? if @promo_code_value
    end

    def available_order?
      remaining_orders.positive?
    end

    def promo_code_acceptable_currency?
      check_promo_code_currency
    end

    private

    def process_promocode
      return unless @promo_code_value

      validate_promo_code && check_promo_code_amount && total_amount
    end

    def check_promo_code_currency
      return true unless @promo_code_value

      order.order_currency == promo_code.promo_code_currency if promo_code
    end

    def check_remaining_orders
      available_order?
    end

    def remaining_orders
      event.event_entry_tickets - event.orders.where('expiring_at > ?', Time.now).count
    end

    def create_order
      @order = event.orders.create(title: event.title,
                                   user: @user,
                                   order_amount: event.price,
                                   order_currency: event.currency,
                                   total_amount: event.price,
                                   expiring_at: 5.minutes.from_now)
    end

    def create_ticket
      @ticket = Ticket.create!(event_id: event.id,
                               order_id: order.id,
                               user_id: @user.id,
                               price: order.order_amount,
                               ticket_currency: order.order_currency,
                               uuid: SecureRandom.uuid)
      event.increment!(:sales_count)
      event.decrement!(:event_entry_tickets)
      send_mail
    end

    def promo_code
      @promo_code ||= PromoCode.find_by(uuid: @promo_code_value)
    end

    def validate_promo_code
      if promo_code.present? && promo_code.promo_code_amount.positive? && (promo_code.promo_code_currency == order.order_currency)
        @order.update(promo_code_id: promo_code.id, total_amount: total_amount)
        if promo_code.promo_code_amount < order.order_amount
          check_order_min_amount(EUR_MIN_AMOUNT) if order.total_amount < EUR_MIN_AMOUNT && order.order_currency == 'eur'
          check_order_min_amount(USD_MIN_AMOUNT) if order.total_amount < USD_MIN_AMOUNT && order.order_currency == 'usd'
          check_order_min_amount(PLN_MIN_AMOUNT) if order.total_amount < PLN_MIN_AMOUNT && order.order_currency == 'pln'
          check_promo_code_amount if order.total_amount > STANDART_MIN_AMOUNT
        else
          create_ticket unless order.total_amount.positive?
        end
      end
    end

    def check_order_min_amount(min_amount)
      @order.update(total_amount: min_amount)
      promo_code.update(promo_code_amount: (min_amount - (event.price - promo_code.promo_code_amount)))
    end

    def total_amount
      order.order_amount - promo_code.promo_code_amount
    end

    def check_promo_code_amount
      promo_code.update(promo_code_amount: -total_amount)
      promo_code.update(promo_code_amount: 0) if promo_code.promo_code_amount.negative?
    end

    def send_mail
      NotificationMailer.success_ticket_payment(@user, @ticket).deliver
    end
  end
end
