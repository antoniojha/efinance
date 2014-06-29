class FinanceItem < ActiveRecord::Base
  belongs_to :goal
  belongs_to :temp_item
  belongs_to :finance_plan
end
