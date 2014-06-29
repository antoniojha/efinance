class RecurBudget < ActiveRecord::Base
  belongs_to :temp_budget_plan
  belongs_to :budget_plan

  validates :title, :price, :category, presence:true
  validates :recur_deduction_date, presence: true, if: :begin_or_end_of_month_selected?
  validates :price, allow_blank: true, numericality:{greater_than_or_equal_to:0.01}  
  validates_uniqueness_of :title, scope: :temp_budget_plan_id
  
  validate  :check_remaining_budget
  
  protected
  def begin_or_end_of_month_selected?
    begin_or_end_of_month == nil
  end
  def check_remaining_budget
  if (category && price)
    temp_budget_plan = TempBudgetPlan.find(temp_budget_plan_id)
   
    user_budgets = RecurBudget.where(:temp_budget_plan_id=>temp_budget_plan_id)
    if category=="Food Budget"
      col="food_budget"
    elsif category=="Finance Budget"
      col="finance_budget"
    elsif category=="Shopping Budget"
      col="shopping_budget"
    elsif category=="Auto Budget"
      col="auto_budget"
    elsif category=="Entertainment Budget"
      col="entertainment_budget"
    elsif category=="Other Budget"
      col="other_budget"
    end

    temp=temp_budget_plan.send(col)-user_budgets.where(:category=>category).sum(:price)
    if(temp && price)
      if (temp < price)
        errors.add(:price, "can't exceed the budget amount of #{temp}")
      elsif temp==price
        errors.add(:price, "can't exceed the budget amount of #{temp}")
      else
      end
    end   
  end
  end
end
