module MailerMacros
  def last_email
    ActionMailer::Base.deliveries.last
  end
  def reset_email
    ActionMailer::Base.deliveries=[]
  end
end
module ClearTable
  def clear_all_data
    ActiveRecord::Base.User.delete_all
  end
end
    
    