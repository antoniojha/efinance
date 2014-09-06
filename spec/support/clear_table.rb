module ClearTable
  def clear_all_data
    ActiveRecord::Base.User.delete_all
  end
end