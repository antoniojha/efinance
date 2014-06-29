class FinancePlansController < ApplicationController
  before_action :set_finance_plan, only: [:show, :edit, :update, :destroy]

  # GET /finance_plans
  # GET /finance_plans.json
  def index
    @finance_plans = FinancePlan.all
    @saved_budget_plan=TempBudgetPlan.find_by(user_id: session[:user_id])
  end

  # GET /finance_plans/1
  # GET /finance_plans/1.json
  def show
  end

  # GET /finance_plans/new
  def new
    @finance_plan = FinancePlan.new
  end

  # GET /finance_plans/1/edit
  def edit
  end

  # POST /finance_plans
  # POST /finance_plans.json
  def create
    @finance_plan = FinancePlan.new(finance_plan_params)

    respond_to do |format|
      if @finance_plan.save
        format.html { redirect_to @finance_plan, notice: 'Finance plan was successfully created.' }
        format.json { render action: 'show', status: :created, location: @finance_plan }
      else
        format.html { render action: 'new' }
        format.json { render json: @finance_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /finance_plans/1
  # PATCH/PUT /finance_plans/1.json
  def update
    respond_to do |format|
      if @finance_plan.update(finance_plan_params)
        format.html { redirect_to @finance_plan, notice: 'Finance plan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @finance_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /finance_plans/1
  # DELETE /finance_plans/1.json
  def destroy
    @finance_plan.destroy
    respond_to do |format|
      format.html { redirect_to finance_plans_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_finance_plan
      @finance_plan = FinancePlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def finance_plan_params
      params.require(:finance_plan).permit(:description, :maturity_date, :recur_period, :amount, :budget_plan, :protection_plan, :emergency_plan, :college_plan, :retirement_plan, :investment_plan)
    end
end
