require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider) }
  it { is_expected.to validate_presence_of(:provider) }
  it { is_expected.to validate_presence_of(:uid) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:image) }

  describe '.from_omniauth' do
    context "when user doesn't exist" do
      it 'creates the user' do
        expect { User.from_omniauth(auth_payload) }.to change { User.count }.by(1)
      end
    end

    context 'when user exists' do
      before { User.from_omniauth(auth_payload) }

      it 'finds the user' do
        expect(User).not_to receive(:create)
        expect(User.from_omniauth(auth_payload)).to eq User.find_by(
          provider: auth_payload.provider,
          uid: auth_payload.uid
        )
      end
    end
  end

  def auth_payload
    @auth_payload ||= OmniAuth::AuthHash.new({
      :provider => 'instagram',
      :uid => 'test',
      :info => {
        :name => 'John Dee',
        :image => 'image_link'
      }
    })
  end
end
