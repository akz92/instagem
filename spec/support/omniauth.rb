# frozen_string_literal: true

OmniAuth.config.mock_auth[:instagram] = OmniAuth::AuthHash.new(
  provider: 'instagram',
  uid: 'test',
  credentials: {
    token: '1234'
  },
  info: {
    name: 'John Dee',
    image: 'image_link'
  }
)

OmniAuth.config.mock_auth[:invalid_instagram] = OmniAuth::AuthHash.new(
  provider: 'instagram',
  uid: 'test',
  credentials: {
    token: '1234'
  },
  info: {}
)

OmniAuth.config.test_mode = true
