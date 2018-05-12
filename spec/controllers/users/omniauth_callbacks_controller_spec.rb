require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe '#instagram' do
    context 'with valid params' do
      before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:instagram] }
      before(:each) { get :instagram }

      it { is_expected.to be_user_signed_in }

      it 'sets success flash message' do
        expect(controller).to set_flash[:notice].to('Successfully authenticated from Instagram account.')
      end

      it 'redirects to root' do
        expect(response).to redirect_to root_url
      end
    end

    context 'with invalid params' do
      before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:invalid_instagram] }
      before(:each) { get :instagram }

      it { is_expected.not_to be_user_signed_in }

      it 'sets failure flash message' do
        expect(controller).to set_flash[:notice].to(
          %q(Could not authenticate you from Instagram because "Name can't be blank and Image can't be blank".)
        )
      end

      it 'redirects to root' do
        expect(response).to redirect_to root_url
      end
    end
  end
end
