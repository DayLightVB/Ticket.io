# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  let!(:event) { build(:event) }
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).is_at_least(10) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:duration) }
    it { is_expected.to validate_presence_of(:event_entry_tickets) }
  end
end
