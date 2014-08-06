require 'will_paginate/array'
require 'time'
require 'date'
class SpendingsController < ApplicationController
  skip_before_filter :verify_authenticity_token  
  before_action :set_spending, only: [:show, :receipt, :edit, :update, :destroy]
  
  # GET /spendings
  # GET /spendings.json

  def index
    
    end_date= Date.current
    start_date=end_date-7
    @spendings = Spending.transaction_after(start_date).where(:user_id=>session[:user_id]).order(:transaction_date_d).reverse
    respond_to do |format|
      format.html
      format.csv{send_data @spendings.to_csv}
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
end
