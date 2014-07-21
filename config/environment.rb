# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
WebFinance::Application.initialize!

#should turn off the field_with_error wrapper when form validation fails
# refer to https://coderwall.com/p/s-zwrg
ActionView::Base.field_error_proc=Proc.new do |html_tag, instance|
  html_tag.html_safe
end
