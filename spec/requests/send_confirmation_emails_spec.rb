require 'spec_helper'

describe "SendConfirmationEmails" do
  before {visit new_user_path}
  subject {page}
  it {should have_content('Sign Up')}
  describe "emails confirmation email when user successfully sign up" do    
    before do
    fill_in "Username", :with=>"testing123"
    fill_in "Email", :with=>"foo@example.com"
    fill_in "Password", :with=>"SecretPassword1?"
    fill_in "Password confirmation", :with=>"SecretPassword1?"
     
    end
   # click_button "Create Account"
  #  find('input[type="submit"]').first.click
  #   it {should have_content('Email Confirmation')}

  end
end
