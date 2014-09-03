class TempBudgetPlansController < ApplicationController
  
  skip_before_action :delete_budget_id_session
  before_action :set_budget_plan, only: [:show, :edit, :update, :destroy] 
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_budget_plan
 

  def new
    @temp_budget_plan = TempBudgetPlan.new
  end
  def create
    @temp_budget_plan = TempBudgetPlan.new(temp_budget_plan_params)
    respond_to do |format|
      if @temp_budget_plan.save
        session[:budget_plan_id]=@temp_budget_plan.id
        session[:recur_week_period]=@temp_budget_plan.recur_period
        format.html {redirect_to new_recur_budget_url}
      else
        format.html {render new_temp_budget_plan_path}
      end
    end
  end
  
  def edit
    @alert_period=@temp_budget_plan.alert_send_period
  end
  def update
    respond_to do |format|
      
      if @temp_budget_plan.update(temp_budget_plan_params)
        flash[:notice]="Budget Plan is updated"
        # delete all previously saved budgets if the recur week period parameter (daily, weekly, yearly, etc) is changed
        if session[:recur_week_period]!=@temp_budget_plan.recur_period
          @budgets=RecurBudget.where(:temp_budget_plan_id=>@temp_budget_plan.id)
          @budgets.destroy_all
          session[:recur_week_period]=@temp_budget_plan.recur_period
        end
        
        # since that the temp_budget_plan form is used both in temp_budget_plan new.html
        # and recur_budget new.html, the following ensures that when the form is updated from
        # recur_budget new.html, it will be redirected to user profile page and if the form is
        # updated from temp_budget_plan new.html, it will be redirected to new_recur_budget page.
        session[:last_page]=request.env['HTTP_REFERER'] || profile_url(session[:user_id])
        if (session[:last_page]==new_recur_budget_url)
          format.html{redirect_to profile_url(session[:user_id])}
        else
          format.html{redirect_to new_recur_budget_url}
        end
      else
        format.html {render new_temp_budget_plan_path}
      end
    end  
  end
  def destroy
    @temp_budget_plan.destroy
      respond_to do |format|
        format.html { redirect_to profile_url(session[:username]), notice:"budget plan was deleted"}
 
    end
  end
  private
    def set_budget_plan
      @temp_budget_plan=TempBudgetPlan.find(params[:id])
    end
    def invalid_budget_plan
      flash[:notice]= "Invalid Budget Plan!"
      logger.error "Attempt to access invalid budget plan"
      render "temp_budget_plans/redirect"
    end
    def temp_budget_plan_params
      params.require(:temp_budget_plan).permit(:recur_period, :food_budget, :finance_budget, :shopping_budget, :auto_budget, :entertainment_budget, :other_budget, :alert_send_period).merge(:user_id=>session[:user_id])
    end
end
