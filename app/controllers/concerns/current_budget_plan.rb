module CurrentBudgetPlan
  extend ActiveSupport::Concern
  private
    def set_budget_plan
  
      if (session[:budget_plan_id])
        @temp_budget_plan=TempBudgetPlan.find(100) 
      end 
    end
end