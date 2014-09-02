class TempBudgetPlan < ActiveRecord::Base
  belongs_to :user
  has_many :recur_budgets, dependent: :destroy
  validates :recur_period, :food_budget, :finance_budget, :shopping_budget, :auto_budget, :entertainment_budget, :other_budget, presence: true
  validates :food_budget, :finance_budget, :shopping_budget, :auto_budget, :entertainment_budget, :other_budget, allow_blank: true, numericality: {greater_than_or_equal_to: 0.01}
  validates :food_budget, :finance_budget, :shopping_budget, :auto_budget, :entertainment_budget, :other_budget, allow_blank: true, numericality: {less_than: 1000000}
  validates :recur_period, allow_blank: true, numericality: {only_integer: true}  
  validates_uniqueness_of :user_id
  
  def normalize_budget_based_on_period
    if recur_period==1
  end
end
