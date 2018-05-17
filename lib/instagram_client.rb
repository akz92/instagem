class InstagramClient
  attr_accessor :user, :client

  def initialize(user)
    @user = user
    @client = Instagram.client(access_token: user.token)
  end

  def recent_media(max_id = nil)
    payload = client.user_recent_media(count: 12, max_id: max_id)

    {
      photos: payload.map { |p| p.dig(:images, :standard_resolution, :url) },
      next_max_id: payload.pagination.next_max_id
    }
  end
end
