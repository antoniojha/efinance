class CreateAdvanceSearches < ActiveRecord::Migration
  def change
    create_table :advance_searches do |t|
      t.string :keyword
      t.datetime :start_date
      t.datetime :end_date
      t.float :minimum_price
      t.float :maximum_price

      t.timestamps
    end
  end
end
