
task :send_email_remind => :environment do
  t=Time.now
  puts "finish sending emails at #{t}"
  @users=User.all
  @users.each do |user| 
    if user
      AlertNotifier.send_email_remind(user).deliver
    end
  end

end