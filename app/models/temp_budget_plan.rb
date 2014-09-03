class TempBudgetPlan < ActiveRecord::Base
  
  belongs_to :user
  has_many :recur_budgets, dependent: :destroy
 # validates :recur_period, :food_budget_v, :finance_budget_v, :shopping_budget_v, :auto_budget_v, :entertainment_budget_v, :other_budget_v, presence: true
 # validates :food_budget_v, :finance_budget_v, :shopping_budget_v, :auto_budget_v, :entertainment_budget_v, :other_budget_v, allow_blank: true, numericality: {greater_than_or_equal_to: 0.01}
 # validates :food_budget_v, :finance_budget_v, :shopping_budget_v, :auto_budget_v, :entertainment_budget_v, :other_budget_v, allow_blank: true, numericality: {less_than: 1000000}
  validates :recur_period, allow_blank: true, numericality: {only_integer: true}  
  validates_uniqueness_of :user_id
  
  #getter
  def food_budget_v
    denormalize(recur_period,food_budget) unless food_budget.blank?
  end
  #setter
  def food_budget_v=(budget)
    self.food_budget=normalize(recur_period,budget.to_f.round(2))
  end  
  def finance_budget_v
    denormalize(recur_period,finance_budget) unless finance_budget.blank?
  end
  def finance_budget_v=(budget)
    self.finance_budget=normalize(recur_period,budget.to_f.round(2))
  end 
  def shopping_budget_v
    denormalize(recur_period,shopping_budget) unless shopping_budget.blank?
  end
  def shopping_budget_v=(budget)
    self.shopping_budget=normalize(recur_period,budget.to_f.round(2))
  end 
  def auto_budget_v
    denormalize(recur_period,auto_budget) unless auto_budget.blank?
  end
  def auto_budget_v=(budget)
    self.auto_budget=normalize(recur_period,budget.to_f.round(2))
  end
  def entertainment_budget_v
    denormalize(recur_period,entertainment_budget) unless entertainment_budget.blank?
  end
  def entertainment_budget_v=(budget)
    self.entertainment_budget=normalize(recur_period,budget.to_f.round(2))
  end 
  def other_budget_v
    denormalize(recur_period,other_budget) unless other_budget.blank?
  end
  def other_budget_v=(budget)
    self.other_budget=normalize(recur_period,budget.to_f.round(2))
  end 
  private
  # this will normalize the budget based on the period entered into monthly rate before saving into database
  # the database will contain the :recur_period column in case there may be a use of it in the future.
  def denormalize(period,budget)
    if period==1
      factor=1
    elsif period ==2
      factor=12
    elsif period==3
      factor=26
    elsif period==4
      factor=52
    elsif period==5
      factor=365
    end
      (budget*12/factor).round(0)
  end
  def normalize(period,budget)
      if period==1
        factor=1
      elsif period ==2
        factor=12
      elsif period==3
        factor=26
      elsif period==4
        factor=52
      elsif period==5
        factor=365
      end
      (budget/12*factor).round(2)
  end

end