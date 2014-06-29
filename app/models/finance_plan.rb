class FinancePlan < ActiveRecord::Base
  has_many :finance_plan, dependent: :destroy
  validates_associated :finance_plan
end
