class HomeController < ApplicationController
  before_action :authenticate_user!

  def show
    c = Instagram.client(access_token: current_user.token)
    r = c.user_recent_media(count: 12, max_id: params[:max_id])

    @photos = r.map { |p| p['images']['standard_resolution']['url'] }
    @next_max_id = r.pagination.next_max_id
  end
end
