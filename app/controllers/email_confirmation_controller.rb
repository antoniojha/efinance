class EmailConfirmationController < ApplicationController
  def new    
    @user=User.find_by_id(session[:user_id])
  end
  def edit
    @user=User.find_by_email_confirmation_token(params[:id])
    if @user.email_authen
      redirect_to profile_url(session[:user_id]), notice: "Email already authenticated!"
    else
      if(!@user)
        redirect_to profile_url(session[:user_id]), notice: "Email authentication didn't go through, try again!"
      else
        @user.email_authen=true
        if @user.save
          flash[:notice]="Email is now authenticated!"
        else
          flash[:notice]="There is an error during the process, please try again later."
        end  
      end   
    end   
  end
  
end
