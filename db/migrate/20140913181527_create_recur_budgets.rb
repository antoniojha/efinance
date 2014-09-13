class CreateRecurBudgets < ActiveRecord::Migration
  def change
    create_table :recur_budgets do |t|
      t.string   :title
      t.decimal  :price
      t.datetime :recur_deduction_date
      t.string   :category
      t.integer  :temp_budget_plan_id
      t.boolean  :begin_or_end_of_month
      t.timestamps
    end
  end
end
