require 'spec_helper'

describe "Users Signup Login and Logoff" do
  describe "signup" do
    before {visit signup_path}
    subject {page}
    it {should have_content('Sign Up')}
    describe "emails confirmation email when user successfully sign up" do   
      user= FactoryGirl.create(:user)
      before do
        
        fill_in "Username", :with=>user.username
        fill_in "Email", :with=>user.email
        fill_in "Password", :with=>user.password
        fill_in "Password confirmation", :with=>user.password 
      end
      it "should have content" do
        click_button "Create Account"
        expect(page).to have_content('Email Confirmation')
        last_email.to.should include(user.email)
      end
    end
end
end
