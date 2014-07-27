require 'spec_helper'

describe "StaticPages" do
  subject {page}
  describe "Home page" do
    before {visit root_path}
    it {should have_content('Home')}
    it {should have_title("WebFinance App|Home")}
    it "should have right links" do
      click_link "About"
      expect(page).to have_title("WebFinance App|About")
      click_link "Contact"
      expect(page).to have_title("WebFinance App|Contact")
      click_link "Home"
      expect(page).to have_title("WebFinance App|Home")
      click_link "Quick Demo"
      expect(page).to have_title("WebFinance App|Demo")
      click_link "Blog"
      expect(page).to have_title("WebFinance App|Blog")
      click_link "Sign In"
      expect(page).to have_content("Login")
    end
  end
  describe "Login page" do
    before {visit login_path}
    it {should have_content('Login')}
  end
  describe "Demo page" do
    before {visit demo_path}
    it {should have_content('Demo')}  
    it {should have_title("WebFinance App|Demo")}   
  end
  describe "About page" do
    before {visit about_path}
    it {should have_content('About')}
    it {should have_title("WebFinance App|About")}  
  end
  describe "Contact page" do
    before {visit contact_path}
    it {should have_content('Contact')} 
    it {should have_title("WebFinance App|Contact")}  
  end
end
