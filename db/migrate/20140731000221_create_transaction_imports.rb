class CreateTransactionImports < ActiveRecord::Migration
  def change
    create_table :transaction_imports do |t|

      t.timestamps
    end
  end
end
