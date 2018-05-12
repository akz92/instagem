class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def instagram
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Instagram") if is_navigational_format?
    else
      session["devise.instagram_data"] = request.env["omniauth.auth"]
      set_flash_message(:notice, :failure, kind: "Instagram", reason: @user.errors.full_messages.to_sentence) if is_navigational_format?
      redirect_to root_path
    end
  end
end
