
class Spending < ActiveRecord::Base
  belongs_to :user
  has_attached_file :picture
  validates_attachment_size :picture, :less_than=>2.megabytes
  #VALID_DATE_FORMAT=/\A\d\d\d\d(-)\d\d(-)\d\d( 00:00:00)\z/
  #/\A\d\d(\/)\d\d(\/)\d\d\d\d\z/

  #validates :transaction_date, format: {with:VALID_DATE_FORMAT}
  validates :title, :price, :transaction_date, :category, presence: true
  validates :price, allow_blank: true, numericality:{greater_than_or_equal_to:0.01}  
  validates_attachment_content_type :picture, :content_type=> ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  #validate :format_and_validate_date, :before=>:before_validation
  scope :transaction_after, ->(date) { where("transaction_date > ?",date-1)}

# def format_and_validate_date
#     begin
#       DateTime.parse(transaction_date.to_s)
     #  transaction_date=DateTime.strptime(transaction_date)  
#     rescue ArgumentError
#       errors.add(:transaction_date, "invalid date")
#     end
#  end
  def check_if_future_transaction_date
    if transaction_date > Date.today
      errors.add(:transaction_date, "can't be in the future")
    end
  #  self.transaction_date=DateTime.strptime(transaction_date,'%m/%d/%Y')
  # for some reason that transaction_date value can't be used directly
  end
end
