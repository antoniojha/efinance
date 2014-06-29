class TempItem < ActiveRecord::Base
  has_many :finance_items, dependent: :destroy
end
