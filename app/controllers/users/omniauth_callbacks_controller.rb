# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :authenticate_user!
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  
 

  def google_oauth2
    @user = User.from_omniauth(auth)
    if @user.present?
      @user.save
      session[:access_token] = auth[:credentials][:token]
      sign_in_and_redirect @user, event: :authentication
    end
  end

  def failure
    
    redirect_to root_path
  end

  def auth
    @auth ||= request.env["omniauth.auth"]
  end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  
  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
