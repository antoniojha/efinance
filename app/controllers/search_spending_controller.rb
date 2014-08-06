require 'will_paginate/array'

class SearchSpendingController < ApplicationController
  skip_before_filter :verify_authenticity_token  
  def create
    end_date= Date.current
    x=params[:transac_period]
    x=x.to_i
    # base on which option is selected, it will return the beginning transaction date to query database
    if params[:transac_period]
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
    end
    if x
      if x==6
        @spendings = Spending.all.where(:user_id=>session[:user_id])
      else
        @spendings = Spending.transaction_after(start_date).where(:user_id=>session[:user_id])
      end 
    end  
    @spendings=@spendings.order(:transaction_date_d).reverse

    respond_to do |format|
      format.html{}
      format.js{}
    end
  end
  def index
    
  end
end
