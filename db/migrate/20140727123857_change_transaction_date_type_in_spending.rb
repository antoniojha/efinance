class ChangeTransactionDateTypeInSpending < ActiveRecord::Migration
  def change
    change_column :spendings,:transaction_date, :string
    add_column :spendings, :transaction_date_d, :datetime
  end
end
