require 'spec_helper'

describe "Users Signup Login and Logoff" do
  user= FactoryGirl.create(:user)
  describe " valid signup" do
    before {visit signup_path}
    it "should visit signup page" do
      expect(page).to have_content('Sign Up')
    end

    before do     
      fill_in "Username", :with=>user.username
      fill_in "Email", :with=>user.email
      fill_in "Password", :with=>user.password
      fill_in "Password confirmation", :with=>user.password 
    end
    it "should create user" do
      expect { click_button "Create Account" }.to change(User, :count).by(1)
    end
    it "should redirect to email confirmation page after sign up" do 
      click_button "Create Account"
      expect(page).to have_content('Email Confirmation')
      expect(last_email.to).to include(user.email)
    end   
  end
  describe "invalid signup" do
    before {visit signup_path}
    it "should display validation error" do
      expect(page).to have_content('Sign Up')
      click_button "Create Account"
      expect(page).to have_content('error')
    end
  end
  describe "invalid sign in" do
    before {visit login_path}
    it "should display validation error" do
      expect(page).to have_content('Login')
      click_button "Login"
      expect(page).to have_content('Invalid user')
    end
  end
  describe "valid sign in" do
    before do     
      visit login_path
      fill_in "Username", :with=>user.username
      fill_in "Password", :with=>user.password
    end
    it "should sign in" do  
      click_button "Login"
      expect(page).to have_content('Invalid user')
    end
  end
end