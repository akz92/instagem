# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email '123-instagram@temp.com'
    provider 'instagram'
    uid '123'
    name 'Instagem'
    token '7765051998.e73a25a.8a4fc7e06a864707bc508b45a302d34d'
  end
end
