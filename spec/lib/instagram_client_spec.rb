# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InstagramClient do
  let!(:user) { User.new(token: '7765051998.e73a25a.8a4fc7e06a864707bc508b45a302d34d') }
  let!(:client) { InstagramClient.new(user) }

  describe '#recent_media' do
    subject { client.recent_media }

    it { is_expected.to be_a(Hash) }
    it { is_expected.to have_key(:photos) }
    it { is_expected.to have_key(:next_max_id) }

    it 'returns 12 photos' do
      expect(subject[:photos].length).to be(12)
    end

    it 'has a next page' do
      expect(subject[:next_max_id]).to be_present
    end
  end
end
