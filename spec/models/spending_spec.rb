require 'spec_helper'

describe Spending do
  before{
    @spending=Spending.new(title:"test",category:"Food Budget",transaction_date:"2014-07-25",price:"100", description:"",picture:"")
  }
  subject{@spending}
  it{should respond_to(:title)}
  it{should respond_to(:category)}
  it{should respond_to(:transaction_date)}
  it{should respond_to(:price)}
  it{should respond_to(:description)}
  it{should respond_to(:picture)}
  it{should be_valid}
  describe "test when title is not entered" do
    before {@spending.title=" "}
    it {should_not be_valid}
  end
  #describe "test when transaction date is not entered" do
  #  before {@spending.transaction_date=nil}
  #  it {should_not be_valid}
  #end
  describe "test when category is not entered" do
    before {@spending.category=" "}
    it {should_not be_valid}
  end
  describe "test when price is not entered" do
    before {@spending.price=" "}
    it {should_not be_valid}
  end
  describe "test when price is below 0.01" do
    before {@spending.price=0}
    it {should_not be_valid}
  end
  describe "test when transaction_date is in the future" do
    before{@spending.transaction_date=Date.today+1}
    it {should_not be_valid}
  end
end
