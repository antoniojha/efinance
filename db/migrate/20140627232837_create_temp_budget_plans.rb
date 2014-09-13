class CreateTempBudgetPlans< ActiveRecord::Migration
  def change
    if !table_exists?("temp_budget_plans")  
      create_table :temp_budget_plans do |t|
        t.decimal  :budget_amount,        precision: 8, scale: 2
        t.datetime :deadline
        t.integer  :recur_period
        t.decimal  :food_budget,          precision: 8, scale: 2
        t.decimal  :finance_budget,       precision: 8, scale: 2
        t.decimal  :shopping_budget,      precision: 8, scale: 2
        t.decimal  :auto_budget,          precision: 8, scale: 2
        t.decimal  :entertainment_budget, precision: 8, scale: 2
        t.decimal  :other_budget,         precision: 8, scale: 2
        t.datetime :created_at
        t.datetime :updated_at
        t.boolean  :finished
        t.integer  :alert_send_period
        t.integer  :user_id
        t.timestamps
      end
    end
  end
end