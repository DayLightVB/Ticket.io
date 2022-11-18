# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Actions with event', type: :controller do
  before(:all) do
    @event = create(:event)
  end

  it 'Does event exist?' do
    @event.valid?
    @event.present?
  end

  it 'Does edit for event work?' do
    @event.update(title: '3212431234')
    expect(@event.title).to eq('3212431234')
  end

  it 'Do we want to soft delete event?' do
    @event.destroy
    expect(Event.find_by(id: @event.id)).to eq(nil)
  end
end
