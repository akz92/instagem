class HomeController < ApplicationController
  before_action :authenticate_user!

  def show
    client = InstagramClient.new(current_user)
    @recent_media = client.recent_media(params[:max_id])
  end
end
