# # frozen_string_literal: true
#
# require 'rails_helper'
#
# describe 'User Sign Up', js: true do
#   context 'when sign up with correct password and email' do
#     it 'shows a message about a confirmation link in the mail' do
#       allow(Devise::Mailer)
#         .to receive(:confirmation_instructions)
#         .and_return(double(deliver: true))
#       visit '/users/sign_up'
#       fill_in 'Email', with: 'simple@email.com'
#       fill_in 'Password', with: '111111111'
#       fill_in 'Password confirmation', with: '111111111'
#       click_button 'Sign up'
#       expect(page).to have_content 'A message with a confirmation link has '
#     end
#   end
#
#   context 'when sign up with incorrect password or email' do
#     it 'redirect to sign up page' do
#       visit '/users/sign_up'
#       fill_in 'Email', with: ''
#       fill_in 'Password', with: '1'
#       fill_in 'Password confirmation', with: '1'
#       click_button 'Sign up'
#       expect(page).to have_content ' errors prohibited this user from being saved'
#     end
#   end
# end
