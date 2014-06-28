module CurrentFinanceItem
  extend ActiveSupport::Concern
  
  private
  def set_current_finance_item
    @temp_item=TempItem.find(session[:temp_item_id])
  rescue ActiveRecord::RecordNotFound
    @temp_item=TempItem.create
    session[:temp_item_id]=@temp_item.id
  end
end