class FinanceItemsController < ApplicationController
  include CurrentFinanceItem
  before_action :set_current_finance_item, only: [:create]
  before_action :set_finance_item, only: [:show, :edit, :update, :destroy]
  
  # GET /finance_items
  # GET /finance_items.json
  def index
    @finance_items = FinanceItem.all
  end

  # GET /finance_items/1
  # GET /finance_items/1.json
  def show

  end

  # GET /finance_items/new
  def new
    @finance_item = FinanceItem.new
  end

  # GET /finance_items/1/edit
  def edit
  end

  # POST /finance_items
  # POST /finance_items.json
  def create
    goal=Goal.find(params[:goal_id])
    goal_text=goal.goal
    @finance_item = @temp_item.finance_items.build(goal: goal)

    respond_to do |format|
      if @finance_item.save
        if (goal_text=="Keep a Budget")
          format.html { redirect_to new_temp_budget_plan_path, notice: 'Finance item was successfully created.' }
        elsif (goal_text=="Set up a Protection")
          format.html { redirect_to new_protection_plan_path, notice: 'Finance item was successfully created.' }  
        elsif (goal_text=="Emergency Fund")
          format.html { redirect_to new_emergency_plan_path, notice: 'Finance item was successfully created.' }  
        elsif (goal_text=="Emergency Fund")
          format.html { redirect_to new_emergency_plan_path, notice: 'Finance item was successfully created.' }
        elsif (goal_text=="College Fund")
          format.html { redirect_to new_college_plan_path, notice: 'Finance item was successfully created.' }
        elsif (goal_text=="Plan for Retirement")
          format.html { redirect_to new_retirement_plan_path, notice: 'Finance item was successfully created.' }
        elsif (goal_text=="Investment")
          format.html { redirect_to new_investment_plan_path, notice: 'Finance item was successfully created.' }  
        end  
        format.json { render action: 'show', status: :created, location: @finance_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @finance_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /finance_items/1
  # PATCH/PUT /finance_items/1.json
  def update
    respond_to do |format|
      if @finance_item.update(finance_item_params)
        format.html { redirect_to @finance_item, notice: 'Finance item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @finance_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /finance_items/1
  # DELETE /finance_items/1.json
  def destroy
    @finance_item.destroy
    respond_to do |format|
      format.html { redirect_to finance_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_finance_item
      @finance_item = FinanceItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def finance_item_params
      params.require(:finance_item).permit(:goal_id, :temp_item_id)
    end
end
