class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
    user=User.find_by(username: params[:username])
    if user and user.authenticate(params[:password])
      if user.email_authen==true
        session[:auth_token]=user.auth_token
        session[:user_id]=user.id
        session[:username]=user.username
        redirect_to profile_url(user.username)
      else
        
        #  resend email confirmation with a new token if user try to sign in without first authenticating email during sign up
        session[:user_id]=user.id
        user.send_email_confirmation
        redirect_to confirmation_url
      end
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id]=nil
    session[:username]=nil
    redirect_to login_url, notice: "Logged out"
  end
end
