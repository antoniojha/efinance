require 'spec_helper'

describe "Users Signup Login and Logoff" do
  describe "signup" do
    subject {page}
    let (:user){FactoryGirl.create(:user)}
    describe "emails confirmation email when user successfully sign up" do   
      before do 
        visit signup_path
        fill_in "Username", :with=>user.username
        fill_in "Email", :with=>user.email
        fill_in "Password", :with=>user.password
        fill_in "Password confirmation", :with=>user.password 
      end
      it {should have_content('Sign Up')}
      it "should have content" do
        click_button "Create Account"
        expect(page).to have_content('Email Confirmation')
        last_email.to.should include(user.email)
      end
    end
    describe "when user sign in" do   
      before do 
        visit login_path
        fill_in "Username", :with=>user.username
        fill_in "Password", :with=>user.password
      end
      it "should have content" do
        click_button "Login"
        expect(page).to have_content('Welcome '+user.username)

      end
    end
  end
end
