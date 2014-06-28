module CurrentFinancePlan
  extend ActiveSupport::Concern

  private
    def set_plan
      @plan=FinancePlan.find(session[:plan_id])
    rescue ActiveRecord::RecordNotFound
      @plan=FinancePlan.create
      session[:plan_id]=@plan.id
    end
    
end