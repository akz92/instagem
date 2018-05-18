# frozen_string_literal: true

Rails.application.routes.draw do
  get 'home/show'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  authenticated :user do
    root 'home#show', as: :authenticated_root
  end

  devise_scope :user do
    root to: 'devise/sessions#new'
  end
end
