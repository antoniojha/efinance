class ReorderSpendingTable < ActiveRecord::Migration
  def change
    change_table :spendings do |t|
      t.change :price, :decimal, after: :description
      t.change :transaction_date, :string, after: :price
      t.change :category, :string, after: :transaction_date
    end
  end
end
