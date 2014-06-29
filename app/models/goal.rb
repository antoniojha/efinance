class Goal < ActiveRecord::Base
  has_many :finance_items
  validates_associated :finance_items
  before_destroy :ensure_not_referenced_by_any_finance_item
  
  private
    # ensure that there are no finance items referencing this financial goal
    def ensure_not_referenced_by_any_finance_item
      if finance_items.empty?
        return true
      else
        errors.add(:base, 'Finance Items present')
        return false
      end      
    end
end
