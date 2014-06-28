require 'Date'

class Spending < ActiveRecord::Base
  belongs_to :user
  has_attached_file :picture#, :styles=>{:small=>"150x150>"}
  VALID_DATE_FORMAT=/\A(0?|1?)[1-9](\/)[0-3]?[0-9](\/)[1-2]?[019]?\d\d\z/

  validates :transaction_date, format: {with:VALID_DATE_FORMAT}
  validates :title, :price, :transaction_date, :category, presence: true
  validates :price, allow_blank: true, numericality:{greater_than_or_equal_to:0.01}  
  validates_attachment_content_type :picture, :content_type=> ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validate :check_if_future_transaction_date

  scope :transaction_after, ->(date) { where("transaction_date > ?",date-1)}
  
  def check_if_future_transaction_date
    if transaction_date > Date.today
      errors.add(:transaction_date, "can't be in the future")
    end
  #  self.transaction_date=DateTime.strptime(transaction_date,'%m/%d/%Y')
  # for some reason that transaction_date value can't be used directly
  end
end
