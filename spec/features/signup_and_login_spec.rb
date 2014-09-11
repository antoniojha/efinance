require 'spec_helper'

describe "Users Signup Login and Logoff" do
  user= FactoryGirl.create(:user)
  describe "signup" do
    before {visit signup_path}
    it "should visit signup page" do
      expect(page).to have_content('Sign Up')
    end
    it "should display validation error" do
      click_button "Create Account"
      expect(page).to have_content('error')
    end
    before do     
      fill_in "Username", :with=>user.username
      fill_in "Email", :with=>user.email
      fill_in "Password", :with=>user.password
      fill_in "Password confirmation", :with=>user.password 
    end
    it "should redirect to email confirmation page after sign up" do 
      click_button "Create Account"
      expect(page).to have_content('Email Confirmation')
      expect(last_email.to).to include(user.email)
    end   
  end
  describe "sign in and sign off" do
  
    it "should sign in" do
      visit login_path
      expect(page).to have_content('Login')
      click_button "Login"
      expect(page).to have_content('Invalid user')
      fill_in "Username", :with=>user.username
      fill_in "Password", :with=>user.password
      click_button "Login"
    #  expect(page).to have_content('Hello '+user.username)
    end
  end
end
