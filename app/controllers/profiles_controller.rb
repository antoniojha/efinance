require 'date'
require 'cgi'
class ProfilesController < ApplicationController

  def new
    @spendings=[]
    @budgets=[]
    @spendings_p=[]
    @budget=TempBudgetPlan.find_by(:user_id=>session[:user_id])   
    # used to conduct search for transaction from spending/advance_search
    if params[:id]
      @advance_search=AdvanceSearch.find(params[:id]) 
    else
      @advance_search=AdvanceSearch.new
    end
    if @budget 
      set_overview_params
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
    
    @user=User.find_by_username(params[:id])

    @finance_items=FinanceItem.all
    @saved_budget_plan=TempBudgetPlan.find_by(user_id: session[:user_id])
    
    # check to see if an entry has been saved today
    @today=Date.today
    @last_trans=Spending.first(:order=>'transaction_date_d DESC')
    if @last_trans
      if @last_trans.transaction_date_d
        if (@today > @last_trans.transaction_date_d)
          @alert_entry=true
        else
          @alert_entry=false  
        end
      else
        @alert_entry=true
      end
    end
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

    def budget_params
      params.require(:budget).permit(:title, :category, :price, :recur_week_period, :transaction_date, :user_id).merge(:temp_budget_plan_id=>session[:budget_plan_id])
    end
    def set_overview_params
      current_month_begin=Date.current.beginning_of_month
      current_month_spendings=Spending.where("transaction_date_d > ?", current_month_begin)
      @spending_food=current_month_spendings.sum(:price, :conditions=>{:category=>"food budget", :user_id=>session[:user_id]})
      @spending_food_p=@spending_food/@budget.food_budget*100
      @spendings_p << @spending_food_p
      @spendings << @spending_food
      @budgets << @budget.food_budget
      @spending_finance=current_month_spendings.sum(:price, :conditions=>{:category=>"finance budget", :user_id=>session[:user_id]})
      @spending_finance_p=@spending_finance/@budget.finance_budget*100
      @spendings_p << @spending_finance_p
      @spendings << @spending_finance
      @budgets << @budget.finance_budget
      @spending_shopping=current_month_spendings.sum(:price, :conditions=>{:category=>"shopping budget", :user_id=>session[:user_id]})
      @spending_shopping_p=@spending_shopping/@budget.shopping_budget*100
      @spendings_p << @spending_shopping_p
      @spendings << @spending_shopping
      @budgets << @budget.shopping_budget
      @spending_auto=current_month_spendings.sum(:price, :conditions=>{:category=>"auto budget", :user_id=>session[:user_id]})
      @spending_auto_p=@spending_auto/@budget.auto_budget*100
      @spendings_p << @spending_auto_p    
      @spendings << @spending_auto
      @budgets << @budget.auto_budget
      @spending_entertainment=current_month_spendings.sum(:price, :conditions=>{:category=>"entertainment budget", :user_id=>session[:user_id]})
      @spending_entertainment_p=@spending_entertainment/@budget.entertainment_budget*100
      @spendings << @spending_entertainment
      @spendings_p << @spending_entertainment_p
      @budgets << @budget.entertainment_budget
      @spending_other=current_month_spendings.sum(:price, :conditions=>{:category=>"other budget", :user_id=>session[:user_id]})
      @spending_other_p=@spending_other/@budget.other_budget*100
      @spendings_p << @spending_other_p
      @spendings << @spending_other
      @budgets << @budget.other_budget   
      @months=[]
      @total_monthly_spendings=[]
      @total_monthly_net_income=[]
      @spending_by_category=[]
      time=Date.current.beginning_of_year
      # The analysis is for spending/net income starting at 1st month of the current year and ending at the current month
      while time<Date.current
        month=time.strftime('%b')
        begin_date=time.beginning_of_month
        end_date=time.end_of_month     
        @months << month
        # query for monthly spending
        spending=Spending.where("transaction_date_d >= ? and transaction_date_d <= ? and price <=?",begin_date, end_date,0).sum(:price, :conditions=>{:user_id=>session[:user_id]})
        # query for monthly net income
        net_income=Spending.where("transaction_date_d >= ? and transaction_date_d <= ?",begin_date, end_date).sum(:price, :conditions=>{:user_id=>session[:user_id]})
        @total_monthly_spendings << spending.to_f.round(2)*(-1)
        
        if net_income <0
          string=""
          string <<"{y:".html_safe
          string << net_income.to_f.round(2).to_s
          string << ",color:'red'}"
          @total_monthly_net_income << string
        else
          @total_monthly_net_income << net_income.to_f.round(2)    
        end      
        time=time.next_month
      end
      
      @months=@months.to_s.html_safe
      @total_monthly_spendings=@total_monthly_spendings.to_s.html_safe
      @total_monthly_net_income=@total_monthly_net_income.to_s.html_safe
      
      # The analysis is for spending breakdown based on different category
      categories=["finance budget","food budget", "auto budget", "shopping budget", "entertainment budget", "other budget"]
      @spendings_in_categories=[]
      this_month_begin=Date.current.beginning_of_month
      total=@total_monthly_spendings.last.to_f
      
      categories.each do |c|
        temp=[]
        s=Spending.where("transaction_date_d > ? and category LIKE ?", this_month_begin, c).sum(&:price)
        if (s/total >=0.1)
          temp=[]
          string="'"+c+"',"+s.to_f.round(2).to_s
          temp << string
          @spendings_in_categories << temp
        else
          string="{name:'"+c+"',y:0.7, dataLabels:{enabled:false}}"
          @spendings_in_categories << string
        end
       
      end
      @spendings_in_categories=@spendings_in_categories.to_s.html_safe
    end
end
