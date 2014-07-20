require 'spec_helper'

describe User do
  before { @user=User.new(username:"Example User", email:"example@example.com")}
  subject {@user}
  it {should respond_to(:username)}
  it {should respond_to(:email)}
  it {should be_valid}
  describe "test when name is not entered" do
    before {@user.name=" "}
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
      user_with_same_email=@user.dup
      user_with_same_username="Different Example User"
      expect(user_with_same_email).to_not be_valid 
    end
  end
  describe "when username is already registered" do
    before do
      user_with_same_name=@user.dup
      user_with_same_name.email="different_example@example.com"
      expect(user_with_same_name).to_not be_valid 
    end
  end
end
