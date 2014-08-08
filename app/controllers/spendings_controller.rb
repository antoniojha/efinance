require 'will_paginate/array'
require 'time'
require 'date'
class SpendingsController < ApplicationController
  skip_before_filter :verify_authenticity_token  
  before_action :set_spending, only: [:show, :receipt, :edit, :update, :destroy]
  
  # GET /spendings
  # GET /spendings.json

  def index
    @params_period=params[:transac_period]
    search_date(params[:transac_period])
    respond_to do |format|
      format.html{}
      format.csv{send_data Spending.to_csv(@spendings)}
      format.xls
      format.js{}
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
    def search_date(transac_period)
      end_date= Date.current
      x=transac_period.to_i
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
        end  
      else
        start_date=end_date-7  
      end
      @spendings=Spending.find_spendings(x,start_date,session[:user_id]).paginate(page:params[:page])
    end
end
