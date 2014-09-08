require 'spec_helper'

describe "UserMailer" do
  describe "send_email_confirmation" do
    let(:user){FactoryGirl.create(:user,:email_confirmation_token=>"anything")}
    let(:mail){EmailConfirmationMailer.send_email_confirm(user)}
    it "sends email confirmation for signup" do
      expect(mail.subject).to eq "Welcome to WebFinance"
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["antoniojha@gmail.com"])
    end 
    it "renders the body with attached email confirmation token" do
      mail.body.encoded.should match(edit_email_confirmation_path(user.email_confirmation_token))
    end
  end
end
