class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
    user=User.find_by(username: params[:username])
    if user and user.authenticate(params[:password])
      session[:auth_token]=user.auth_token
    #  session[:budget_plan_id]=TempBudgetPlan.find_by(user_id: user.id).id

      redirect_to profile_url(user.auth_token)
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id]=nil
    redirect_to login_url, notice: "Logged out"
  end
end
