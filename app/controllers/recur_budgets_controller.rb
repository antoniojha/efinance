class RecurBudgetsController < ApplicationController

  skip_before_action :delete_budget_id_session
  #before_action :set_saved_transaction_date
  before_action :set_budget, only: [:show, :edit, :update, :destroy]

  before_action :set_recur_deduction_date, only: [:create]
  before_action :set_budget_display, only: [:new, :create]
  before_action :set_error_display, only: [:new, :create]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_budget
  
  # GET /budgets
  # GET /budgets.json
  def index
    @budgets = RecurBudget.all
  end

  # GET /budgets/1
  # GET /budgets/1.json
  def show
 
  end

  # GET /budgets/new
  def new
    @temp_budget_plan= TempBudgetPlan.find(session[:budget_plan_id])
    @budget = RecurBudget.new
    @budgets= RecurBudget.where(:temp_budget_plan_id =>@temp_budget_plan.id).all  
    @user_budgets=RecurBudget.where(:temp_budget_plan_id=> @temp_budget_plan.id)
    set_recur_period

  end

  # GET /budgets/1/edit
  def edit
  end

  # POST /budgets
  # POST /budgets.json
  def create
    @budget = RecurBudget.new(budget_params)
    set_recur_period
    
    respond_to do |format|
      if @budget.save
        
        set_budget_display
        format.js {@category=@budget.category} # pass in category to identify where to place current item id to create highlight effect
        AlertNotifier.alert.deliver
        format.json { render action: 'show', status: :created, location: @budget }
      else
        flash[:error]= @budget.errors.full_messages
        errors=flash[:error]
        is_price_error=false
        
        errors.each do |e|
          e=e[0..38] #keeps the partial error string comparable
          if e=="Price can't exceed the budget amount of"
            is_price_error=true
          end
        end
        if (is_price_error)
          format.js {@category_error=@budget.category}
        else
          format.js
        end
        format.html {render 'new'}
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
   end
  end

  # PATCH/PUT /budgets/1
  # PATCH/PUT /budgets/1.json
  def update
    respond_to do |format|
      if @budget.update(budget_params)
        format.html { redirect_to @budget, notice: 'Budget was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgets/1
  # DELETE /budgets/1.json
  def destroy
    @budget.destroy
    respond_to do |format|
      format.html { redirect_to budgets_url }
      format.json { head :no_content }
    end
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_budget
      @budget = RecurBudget.find(params[:id])
    end
   # def set_saved_transaction_date
   #   date=params[:budget][:transaction_date]
   #   params[:budget][:transaction_date]=date.to_time
   # end
    # Never trust parameters from the scary internet, only allow the white list through.
    
    def invalid_budget
      flash[:notice]= "Invalid Budget"
      logger.error "Attempting to access invalid budget"
      render "budgets/redirect"
    end
    def set_recur_period
      @temp_budget_plan= TempBudgetPlan.find(session[:budget_plan_id])
      recur_num=@temp_budget_plan.recur_period
      if (recur_num==1)
        @period= "year"
      elsif (recur_num==2)
        @period= "month"
      elsif (recur_num==3)
        @period="bi-week"
      elsif (recur_num==4)
        @period="week"
      elsif (recur_num==5)
        @period="day"                 
      end
    end
    def set_error_display
      flash[:error]=nil
    end
    def set_budget_display
      @temp_budget_plan= TempBudgetPlan.find(session[:budget_plan_id])
      @budgets_plan_category=["food_budget","finance_budget","shopping_budget","auto_budget","entertainment_budget", "other_budget"]
      @budgets_category=["Food Budget", "Finance Budget","Shopping Budget", "Auto Budget", "Entertainment Budget", "Other Budget"]
      @budgets_plan_category.zip @budgets_category
      @user_budgets=RecurBudget.where(:temp_budget_plan_id=> @temp_budget_plan.id)      
      @hash={}
 
      @budgets_plan_category.zip(@budgets_category).each do |b_plan_cat,b_cat|
        temp=@temp_budget_plan.send(b_plan_cat)-@user_budgets.where(:category=>b_cat).sum(:price)
        @hash=@hash.merge( b_plan_cat => temp)
      end      
    end

    def set_recur_deduction_date
      if params[:recur_budget][:begin_or_end_of_month]
        params[:recur_budget][:recur_deduction_date]=nil
      end
    end
    def budget_params
      params.require(:recur_budget).permit(:title, :category, :price, :recur_deduction_date, :begin_or_end_of_month).merge(:temp_budget_plan_id=>session[:budget_plan_id])
    end
end
