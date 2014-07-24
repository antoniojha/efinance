class ApplicationController < ActionController::Base
  #include CurrentBudgetPlan
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :reset_flash_error
  before_action :authorize, except: [:about, :contact, :demo, :home, :blog]

  rescue_from ActiveRecord::RecordNotFound, with: :invalid_page
  
  protected
  # this function is created for temporary use to test out user id feature
    def set_user_id
      
    end
    def authorize
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: "Please log in"
      end
    end

    def delete_budget_plan_id_session
      session[:budget_plan_id]=nil
    end
    def reset_flash_error
      flash[:error]=nil
    end
    def invalid_page
      flash[:notice]= "Accessing an invalid page!"
      logger.error "Attempt to access invalid page"
      redirect_to profile_url(session[:user_id])
    end
end
