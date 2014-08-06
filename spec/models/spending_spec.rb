require 'spec_helper'

describe Spending do
  before{
    @spending=Spending.new(title:"test",category:"Food Budget",transaction_date:"07/25/2014",transaction_date_d:"2014-07-25",price:"100", description:"",:picture=>(Rails.root+"spec/fixtures/images/Ruby_on_Rails_logo.jpg").open)
    #since the above code will result with picture_content_type=application/octet-stream
    #manually set the picture_content_type below to ensure test passes.
    @spending.picture_content_type="image/jpg"
  }
  subject{@spending}
  describe "test for a valid spending" do
    it{should respond_to(:title)}
    it{should respond_to(:category)}
    it{should respond_to(:transaction_date)}
    it{should respond_to(:price)}
    it{should respond_to(:description)}
    it{should respond_to(:picture_file_name)}
    it{should respond_to(:picture_content_type)}
    it{should respond_to(:picture_file_size)}
    it{should be_valid}
  end
 
  describe "test when title is not entered" do
    before {@spending.title=" "}
    it {should_not be_valid}
  end
  describe "test when transaction date is not entered" do
    before {@spending.transaction_date=" "}
    it {should_not be_valid}
  end
  
  describe "test when category is not entered" do
    before {@spending.category=" "}
    it {should_not be_valid}
  end
  describe "test when price is not entered" do
    before {@spending.price=" "}
    
    it {should_not be_valid}
  end
 # describe "test when price is below 0.01" do
 #   before {@spending.price=0}
 #   it {should_not be_valid}
 # end
  describe "test when transaction_date is in the future" do
    before{@spending.transaction_date=(Date.today+1).strftime('%m/%d/%Y').to_s
           @spending.transaction_date_d=Date.today+1
      }
   
    it {should_not be_valid}
  end

  describe "test when transaction_date has valid date" do
    it "should be valid" do
      @spending.transaction_date_d=Date.today
      @spending.transaction_date=Date.today.strftime('%m/%d/%Y')
      expect(@spending).to be_valid
    end
  end
  describe "test when transaction_date has invalid format" do
    
      dates=%w[07-10-2014 2014-07-03 2014/07/03 07x03x2014 07\03\2014]
      dates.each do |invalid_date|
        before{@spending.transaction_date=invalid_date}
        
        it{ should_not be_valid}
      end      
  
  end
 # describe "test when transaction_date has invalid date" do
 
 #     dates=%w[06/32/2014 06/40/2014 13/01/2014 02/30/2014]
     
 #     dates.each do|invalid_date|
 #       before{@spending.transaction_date=invalid_date}
        
 #       it {should_not be_valid}
 #     end
   
 # end
  describe "test when transaction_date has valid format" do
    it "should be valid" do
      dates=%w[07/13/2014 07/13/14 7/13/14 07/13/14 07/13/2014 7/13/2014]
      dates.each do |valid_date|
        @spending.transaction_date=valid_date
        @spending.transaction_date_d=DateTime.strptime(valid_date,'%m/%d/%Y')
        expect(@spending).to be_valid
      end      
    end    
  end  
  describe "test when paperclip upload file too big" do
    before{
      @spending=Spending.new(title:"test",category:"Food Budget",transaction_date:"07/25/2014",transaction_date_d:"2014-07-25",price:"100", description:"",:picture=>(Rails.root+"spec/fixtures/images/big_file.jpg").open)
      @spending.picture_content_type="image/jpg"
    }
    it {should_not be_valid}
  end
end
