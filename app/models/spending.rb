
class Spending < ActiveRecord::Base
  belongs_to :user
  has_attached_file :picture
  validates_attachment_size :picture, :less_than=>2.megabytes
  VALID_DATE_FORMAT=/\A(\d\d|\d)(\/)(\d\d|\d)(\/)(\d\d\d\d|\d\d)\z/
  validates :transaction_date, format: {with:VALID_DATE_FORMAT}, if: :check_transaction_date_is_string
  validates :title, :price, :category, presence: true
  validates :transaction_date, presence: true, if: :check_transaction_date_is_string
  validates_uniqueness_of :description, scope: [:user_id, :title, :category, :transaction_date,:price]
  #validates :price, allow_blank: true, numericality:{greater_than_or_equal_to:0.01}  
  validates_attachment_content_type :picture, :content_type=> ["image/jpg", "image/jpeg", "image/png", "image/gif", "image/pjpeg"]
 
 # scope :transaction_after, ->(date) { where("transaction_date_d > ?",date-1)}  
  # this is actually two validation tests in one line
  validate :check_if_future_transaction_date, if: :check_and_validate_date
  validate :check_and_validate_date
  # this is used for importing data from Excel since transaction_date can be date format
  def check_transaction_date_is_string
    if transaction_date
      true
    else
      false
    end
  end
  def check_and_validate_date  
    if !self.transaction_date_d
      self.transaction_date_d=DateTime.strptime(transaction_date,'%m/%d/%Y').in_time_zone
    true
    else
      self.transaction_date=self.transaction_date_d.strftime('%m/%d/%Y')
    end
    rescue
    errors.add(:transaction_date, "invalid date")
    false 
  end

  def check_if_future_transaction_date
    if self.transaction_date_d > Date.today
      errors.add(:transaction_date, "can't be in the future")
    end
  end
  def self.find_spendings(condition_num,start_date,user_id)
      if condition_num==6
        where(:user_id=>user_id).order(:transaction_date_d).reverse 
      else
        where("transaction_date_d > ?",start_date-1).where(:user_id=>user_id).order(:transaction_date_d).reverse 
      end 
  end

  @column_names=%w[id title description price transaction_date category]
  def self.to_csv(all_spendings)
    CSV.generate do |csv|
      csv << @column_names
      all_spendings.each do |spending|
        csv << spending.attributes.values_at(*@column_names)
      end
    end
  end
end
