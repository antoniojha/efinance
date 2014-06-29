class BudgetPlan < ActiveRecord::Base
  has_many :budgets, dependent: :destroy
  validates :salary, :recur_period, :food_budget, :finance_budget, :shopping_budget, :auto_budget, :entertainment_budget, :other_budget, presence: true
  validates :food_budget, :finance_budget, :shopping_budget, :auto_budget, :entertainment_budget, :other_budget, allow_blank: true, numericality: {greater_than_or_equal_to: 0.01}
  validates :food_budget, :finance_budget, :shopping_budget, :auto_budget, :entertainment_budget, :other_budget, allow_blank: true, numericality: {less_than: 1000000}
  validates :salary, allow_blank: true, numericality: {greater_than_or_equal_to: 0.01}
  validates :salary, allow_blank: true, numericality: {less_than: 1000000000}
  validates :recur_period, allow_blank: true, numericality: {only_integer: true}  
  validate :budget_salary_cannot_be_less_than_total_budget
 
  def budget_salary_cannot_be_less_than_total_budget
    if food_budget && finance_budget && shopping_budget && auto_budget && entertainment_budget && other_budget
      total=food_budget+finance_budget+shopping_budget+auto_budget+entertainment_budget+other_budget
      if total > salary
        errors.add(:salary, "salary can't be less than total budget")
      end
    end
  end
end