# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  login_user

  it 'has a current_user' do
    expect(subject.current_user).to_not eq(nil)
  end

  describe '#show' do
    before(:each) { get :show }

    it 'is successful' do
      expect(response).to be_success
    end

    it 'renders next_page link' do
      assert_select('.photos-next-page')
    end
  end
end
