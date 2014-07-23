class EmailConfirmationController < ApplicationController
  def new    
  end
  def edit
    @user=User.find_by_email_confirmation_token(params[:id])
  end
end
