class RefundTicket< ApplicationServices
  def initialize(ticket)
    @ticket = ticket
  end

  def call
    @ticket.restore
    @ticket.update(status: "refunded")
    @ticket.update(promo_code_id: promocode.id)
    NotificationMailer.ticket_refund(@ticket.user, @ticket, promocode).deliver
  end

  def promocode
    promocode_uuid = SecureRandom.uuid
    promocode_currency = @ticket.ticket_currency
    PromoCode.create(user_id: @ticket.user_id, ticket_id: @ticket.id, promo_code_amount: @ticket.price,
                     promo_code_currency: promocode_currency, uuid: promocode_uuid)
  end
end
