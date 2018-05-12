require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:auth) { OmniAuth.config.mock_auth[:instagram] }

  it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider) }
  it { is_expected.to validate_presence_of(:provider) }
  it { is_expected.to validate_presence_of(:uid) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:image) }

  describe '.from_omniauth' do
    context "when user doesn't exist" do
      it 'creates the user' do
        expect { User.from_omniauth(auth) }.to change { User.count }.by(1)
      end
    end

    context 'when user exists' do
      before { User.from_omniauth(auth) }

      it 'finds the user' do
        expect(User).not_to receive(:create)
        expect(User.from_omniauth(auth)).to eq User.find_by(
          provider: auth.provider,
          uid: auth.uid
        )
      end
    end
  end
end
