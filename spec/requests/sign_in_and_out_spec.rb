require 'spec_helper'

describe "user sign in" do
  before do
    @user=FactoryGirl.create(:user)
    @user.save
  end
  describe "valid sign in" do
    before do 
      page.set_rack_session(:user_id => @user.id)
      page.set_rack_session(:username => @user.username)
      visit login_path
      expect(page).to have_content('Login')
      fill_in "Username", :with=>@user.username
      fill_in "Password", :with=>@user.password 
    end
    it "shouldn't sign in but direct to Email Confirmation page b/c user's has not confirmed email yet" do  
      click_button "Login"
      expect(page).to have_content('Email Confirmation')
    end
    it "should sign in after use confirmed email" do
      @user.update_attributes(email_authen:'true')
      click_button "Login"
      expect(page).to have_content('Hello '+@user.username)
      expect(page).to have_link('Sign Out')
      expect(page).to have_link('Profile')
      expect(page).not_to have_link('Sign In')
      expect(page).not_to have_link('Sign Up')
    end  
  end
end
describe "User Sign Out" do
  before do
    @user=FactoryGirl.create(:user, :email_authen=>'true')
    @user.save
    page.set_rack_session(:user_id => @user.id)
    page.set_rack_session(:username => @user.username)
    visit profile_path(@user.username)
  end
  it "should sign out" do
    expect(page).to have_content('Hello '+@user.username)
    click_link "Sign Out"
    expect(page).to have_content('Logged Out')
    expect(page).not_to have_link('Sign Out')
    expect(page).not_to have_link('Profile')
    expect(page).to have_link('Sign In')
    expect(page).to have_link('Sign Up')
  end
end
