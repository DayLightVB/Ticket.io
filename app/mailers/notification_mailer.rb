# frozen_string_literal: true

class NotificationMailer < ActionMailer::Base
  default from: 'ticketsell@no_replay.com'

  def success_ticket_payment(user, ticket)
    @ticket = ticket
    pdf = WickedPdf.new.pdf_from_string(
      render_to_string('tickets/ticket.html.haml', layout: 'pdf.html.haml')
    )
    attachments["Ticket#{@ticket}.pdf"] = pdf
    @greeting = 'Hi'

    mail to: user.email
  end

  def ticket_refund(user, ticket, promocode)
    @ticket = ticket
    @promocode = promocode
    mail to: user.email
  end
end
