require 'will_paginate/array'
require 'time'
require 'date'
class SpendingsController < ApplicationController
  skip_before_filter :verify_authenticity_token  
  before_action :set_spending, only: [:show, :receipt, :edit, :update, :destroy]
  # GET /spendings
  # GET /spendings.json

  def index
    if params[:transac_period]
      @params_period=params[:transac_period].to_i
    else
      @params_period=nil
    end
    @spendings=nil
  
    if @params_period!=6
      #return the start date based on params[:transac_period]. If there is no parameter, use 7 days ago as default.
      @start_date= return_start_date(@params_period)
      @spendings=Spending.find_spendings(@start_date,session[:user_id]).paginate(page:params[:page])   
    else
      @spendings=Spending.all.where(:user_id=>session[:user_id]).paginate(page:params[:page])
      @start_date=@spendings.last.transaction_date_d
    end
    # in case that user hasn't input anything in the specified period.
    if (@spendings!=nil &&@spendings.count>0)
      @start_date=@spendings.last.transaction_date_d
      @end_date=@spendings.first.transaction_date_d
    end
    @text=return_text(@params_period)
    # Advance search implementation
   
    if params[:id]
      @advance_search=AdvanceSearch.find(params[:id])
      @spendings=@advance_search.transactions.where(:user_id=>session[:user_id]).paginate(page:params[:page])
      if @spendings.count>0
        @start_date=@spendings.last.transaction_date_d
        @end_date=@spendings.first.transaction_date_d
      end
      #define class to display tab
      @normal_search_class=""
      @advance_search_class="active"     
      # define class to display normal search form or advance_search form
      @normal_search_class2="no_display"
      @advance_search_class2=""
    else
      @advance_search=AdvanceSearch.new
      #define class to display tab
      @normal_search_class="active"
      @advance_search_class=""     
      # define class to display normal search form or advance_search form
      @normal_search_class2=""
      @advance_search_class2="no_display"
    end
    
    respond_to do |format|
      format.html{}
      format.csv{send_data Spending.to_csv(@spendings)}
      format.xls
     end
  end

  # GET /spendings/1
  # GET /spendings/1.json
  def show
  end
  def receipt
    
  end
  # GET /spendings/new
  def new
    @spending = Spending.new
  end

  # GET /spendings/1/edit
  def edit
  end

  # POST /spendings
  # POST /spendings.json
  def create
    @spending = Spending.new(spending_params)
      respond_to do |format|
        if @spending.save 
          format.html { redirect_to new_spending_url, notice: 'Spending was successfully created.' }
          format.json { render action: 'show', status: :created, location: @spending }
        else
          format.html { render action: 'new' }
          format.json { render json: @spending.errors, status: :unprocessable_entity }
        end
      end
  end 
  # PATCH/PUT /spendings/1
  # PATCH/PUT /spendings/1.json
  def update
    respond_to do |format|
      if @spending.update(spending_params)
        format.html { redirect_to @spending, notice: 'Spending was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @spending.errors, status: :unprocessable_entity }
      end
    end
  end
  def upload

  end
  # DELETE /spendings/1
  # DELETE /spendings/1.json
  def destroy
    @spending.destroy
    respond_to do |format|
      format.html { redirect_to spendings_url }
      format.json { head :no_content }
    end
  end
  def import
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spending
      @spending = Spending.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spending_params
      params.require(:spending).permit(:title, :description, :image_url, :price, :transaction_date, :picture, :category).merge(:user_id=> session[:user_id])
    end
    def advance_search_params
      params.require(:advance_search).permit(:keyword, :start_date, :end_date, :minimum_price, :maximum_price, :hidden_value)
    end
    def return_start_date(transac_period)
      end_date= Date.current
      x=transac_period
      
      if transac_period
        if x==1
          start_date=end_date-7
        elsif x==2
          start_date=end_date.beginning_of_month
        elsif x==3
          start_date=end_date.ago(1.month).beginning_of_month
        elsif x==4
          start_date=end_date.ago(3.month).beginning_of_month  
        elsif x==5
          start_date=end_date.ago(6.month).beginning_of_month
        elsif x==6
          start_date=nil
        end  
      else
        start_date=end_date-7  
      end
    end
    def return_text(params_period)
      if params_period==1
        text="last week"
      elsif params_period==2
        text="this month"
      elsif params_period==3
        text="last month"
      elsif params_period==4
        text="3 months ago"
      elsif params_period==5
        text="6 months ago"
      elsif params_period==6
        text="beginning"   
      else
        text="last 7 days"     
      end
    end
end
