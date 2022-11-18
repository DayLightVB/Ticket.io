# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfilesController, type: :routing do
  describe 'routing' do
    it { expect(get: '/profiles').to route_to('profiles#index') }

    it { expect(get: '/profiles/new').to route_to('profiles#new') }

    it { expect(get: '/profiles/1').to route_to('profiles#show', id: '1') }

    it { expect(get: '/profiles/1/edit').to route_to('profiles#edit', id: '1') }

    it { expect(post: '/profiles').to route_to('profiles#create') }

    it {  expect(put: '/profiles/1').to route_to('profiles#update', id: '1') }

    it {  expect(patch: '/profiles/1').to route_to('profiles#update', id: '1') }

    it {  expect(delete: '/profiles/1').to route_to('profiles#destroy', id: '1') }
  end
end
