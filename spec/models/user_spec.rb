require 'spec_helper'

describe User do
  before { @user=User.new(username:"Example User", email:"example@example.com", password: "Example_password12?", password_confirmation: "Example_password12?")}
  subject {@user}
  it {should respond_to(:username)}
  it {should respond_to(:email)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should be_valid}
  describe "test when name is not entered" do
    before {@user.username=" "}
    it {should_not be_valid}
  end
  describe "test when email is not entered" do
    before {@user.email=" "}
    it {should_not be_valid}
  end
  describe "when username is too long" do
    before {@user.username="a"*51}
    it {should_not be_valid}
  end
  describe "when username is too short" do
    before {@user.username="a"*6}
    it {should_not be_valid}
  end

  describe "when email is already registered" do
    before do
      @user_with_same_email=@user.dup
      @user_with_same_email.username="Different Example User"
      @user_with_same_email.save
    end
    it "should not be valid" do
      expect(@user).not_to be_valid 
    end
  end
  describe "when username is already registered" do
    before do
      @user_with_same_name=@user.dup
      @user_with_same_name.email="different_example@example.com"
      @user_with_same_name.save
    end
    it "should not be valid" do
      expect(@user).not_to be_valid 
    end
  end
  
  describe "when password is different from password_confirmation" do 
    before do
      @user_with_different_password=@user.dup
      @user_with_different_password.password_confirmation= "Example_password12!"
      @user_with_different_password.save
    end 
    it "should not be valid" do
      expect(@user_with_different_password).not_to be_valid
    end
  end
end
