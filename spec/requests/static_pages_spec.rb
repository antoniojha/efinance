require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should direct to the login page" do
      visit '/login'
      expect(page).to have_content('Login')
    end
    it "should direct to the home page" do
      visit root_path
      expect(page).to have_content('Login')
    end
  end
  describe "Demo page" do
    it "should direct to the demo page" do
      visit '/static_pages/demo'
      expect(page).to have_content('Demo')
    end
    subject {page}
  #  it "should have title demo" do
  #    visit '/static_pages/demo'
  #    should have_title("WebFinance App|Demo")
  #  end
  end
  describe "About page" do
    it "should direct to the about page" do
      visit '/static_pages/about'
      expect(page).to have_content('About')
    end
  #  it "should have title about" do
  #    visit '/static_pages/about'
  #    expect(page).to have_selector("title",text:"WebFinance App|About")
  #  end
  end
  describe "Contact page" do
    it "should direct to the contact page" do
      visit '/static_pages/contact'
      expect(page).to have_content('Contact')
    end
  #  it "should have title contact" do
  #    visit '/static_pages/contact'
  #    expect(page).to have_title("WebFinance App|Contact")
  #  end
  end
end
