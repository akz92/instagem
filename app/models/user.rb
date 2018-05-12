class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :trackable,
    :validatable, :omniauthable, omniauth_providers: %i[instagram]

  # Validations
  validates :uid, uniqueness: { scope: :provider }
  validates :provider, :uid, :name, :image, :token, presence: true

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = User.temp_email(auth)
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      user.image = auth.info.image
      user.token = auth.credentials.token
    end
  end

  private

  def self.temp_email(auth)
    "#{auth.uid}-#{auth.provider}@temp.com"
  end
end
