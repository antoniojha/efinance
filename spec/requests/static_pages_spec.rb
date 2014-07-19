require 'spec_helper'

describe "StaticPages" do
  subject {page}
  describe "Home page" do
    before {visit root_path}
    it {should have_content('Home')}
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
