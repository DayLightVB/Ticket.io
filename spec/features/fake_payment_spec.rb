# NEED TO FIX

# # frozen_string_literal: true
#
# require 'rails_helper'
#
# describe 'User Buy a ticket', js: true do
#   let!(:user) { create(:user) }
#   let!(:event) { create(:event) }
#
#   it 'buing ticket ' do
#    visit "/events/#{event.id}"
#    page.execute_script 'window.scrollBy(0,10000)'
#    click_on 'Buy a ticket'
#    sleep 5
#    fill_in 'cardNumber', with: '5454 5454 5454 5454'
#    fill_in 'cardExpiry', with: '1123'
#    fill_in 'cardCvc', with: '333'
#    fill_in 'billingName', with: '333'
#    click_on 'Pay'
#    sleep 10
#    expect(page).to have_content 'Success'
#   end
#
#   # it 'redirect to stripe' do
#   #
#   # end
# end
