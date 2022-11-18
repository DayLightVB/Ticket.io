# frozen_string_literal: true

require 'rails_helper'
require 'stripe_mock'

RSpec.describe 'webhooks_controller', type: :controller do
  describe 'validate Stripe webhooks' do

    before do
      @order = create(:order,
                      user_id: user.id,
                      event_id: event.id,
                      stripe_product_id: 'prod_LA7CKE873YILhF',
                      stripe_price_id: 'price_1KTlmSDXV40BRBn1Q24C8vaI',
                      session_id: 'cs_test_a14TbJIAb8gxY5i1jQzaHUGtuLb0UI30aKYmLnvwt92q6PdpFrV2JLZ01t')
      StripeMock.start
      allow(NotificationMailer).to receive(:success_ticket_payment).and_return(double(deliver: true))
      Stripes::SuccessStripe.new(session_with_expand).call
    end

    after { StripeMock.stop }

    let(:stripe_helper) { StripeMock.create_test_helper }
    let(:user) { create(:user) }
    let(:event) { create(:event, sales_count: 0) }
    let(:session_with_expand) { StripeMock.mock_webhook_event('checkout.session.completed') }

    it 'check if ticket created ' do
      allow(NotificationMailer).to receive(:success_ticket_payment).and_return(double(deliver: true))
      Stripes::SuccessStripe.new(session_with_expand).call
      Ticket.find_by(order_id: @order.id).present?
    end

    it 'check event sales count ' do
      expect(Order.last.event.sales_count).to eq(1)
    end

    it 'check event event entry tickets  ' do
      expect(Order.last.event.event_entry_tickets).to eq(1)
    end

    it 'check if order has a ticket' do
      @order.ticket_id.present?
    end
  end
end
