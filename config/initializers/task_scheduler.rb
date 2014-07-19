require 'rubygems'
require 'rake'
require 'rufus/scheduler'


email_scheduler=Rufus::Scheduler.new

email_scheduler.every "10s" do
  system "rake send_email_remind RAILS_ENV=development"
end
