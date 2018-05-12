Rails.application.routes.draw do
  get 'home/show'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'home#show'
end
