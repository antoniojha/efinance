class ProfilesController < ApplicationController
  before_action :set_budget, only: [:show, :destroy, :edit, :update]
  before_action :personal_page, only:[:show]
  
  def personal_page
    if params[:id]
      x=params[:id]
      y=session[:user_id]
      unless (x==y)
        redirect_to login_url
      end
    end
  end
  def new
    @spendings=[]
    @budgets=[]
    @spendings_p=[]

    @budget=TempBudgetPlan.find_by(:user_id=>session[:user_id])   
    if @budget 
    @spending_food=Spending.sum(:price, :conditions=>{:category=>"Food Budget", :user_id=>session[:user_id]})
    @spending_food_p=@spending_food/@budget.food_budget*100
    @spendings_p << @spending_food_p
    @spendings << @spending_food
    @budgets << @budget.food_budget
    @spending_finance=Spending.sum(:price, :conditions=>{:category=>"Finance Budget", :user_id=>session[:user_id]})
    @spending_finance_p=@spending_finance/@budget.finance_budget*100
    @spendings_p << @spending_finance_p
    @spendings << @spending_finance
    @budgets << @budget.finance_budget
    @spending_shopping=Spending.sum(:price, :conditions=>{:category=>"Shopping Budget", :user_id=>session[:user_id]})
    @spending_shopping_p=@spending_shopping/@budget.shopping_budget*100
    @spendings_p << @spending_shopping_p
    @spendings << @spending_shopping
    @budgets << @budget.shopping_budget
    @spending_auto=Spending.sum(:price, :conditions=>{:category=>"Auto Budget", :user_id=>session[:user_id]})
    @spending_auto_p=@spending_auto/@budget.auto_budget*100
    @spendings_p << @spending_auto_p    
    @spendings << @spending_auto
    @budgets << @budget.auto_budget
    @spending_entertainment=Spending.sum(:price, :conditions=>{:category=>"Entertainment Budget", :user_id=>session[:user_id]})
    @spending_entertainment_p=@spending_entertainment/@budget.entertainment_budget*100
    @spendings << @spending_entertainment
    @spendings_p << @spending_entertainment_p
    @budgets << @budget.entertainment_budget
    @spending_other=Spending.sum(:price, :conditions=>{:category=>"Other Budget", :user_id=>session[:user_id]})
    @spending_other_p=@spending_other/@budget.other_budget*100
    @spendings_p << @spending_other_p
    @spendings << @spending_other
    @budgets << @budget.other_budget   
    end 
  end
  
  def index
    @budgets=RecurBudget.all
    @budget=RecurBudget.new
  end
  
  def create
    @budget=RecurBudget.new(budget_params)
    respond_to do |format|
      if @budget.save
        format.html { redirect_to new_profiles_path, notice: 'Budget was successfully created.' }
        format.js{@category=@budget.category}
        format.json { render action: 'show', status: :created, location: @budget }
      else
        
        flash[:error]= @budget.errors.full_messages
        format.js     
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end   
  end
  
  def show
    
    @user=User.find(params[:id])

    @finance_items=FinanceItem.all
    @saved_budget_plan=TempBudgetPlan.find_by(user_id: session[:user_id])
  end
  def destroy
    @budget=RecurBudget.find(params[:id])
    @budget.destroy
    respond_to do |format|
      format.html {redirect_to profiles_url}
    end
  end
  def finance_goal
   @goals=Goal.all
  end
  private
    def set_budget
    #  @budget=User.find(params[:id]) <-- taken out until implementing sign-in feature
    end
    def budget_params
      params.require(:budget).permit(:title, :category, :price, :recur_week_period, :transaction_date, :user_id).merge(:temp_budget_plan_id=>session[:budget_plan_id])
    end
end
