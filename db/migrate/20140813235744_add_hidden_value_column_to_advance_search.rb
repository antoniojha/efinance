class AddHiddenValueColumnToAdvanceSearch < ActiveRecord::Migration
  def change
    add_column :advance_searches,:hidden_value, :string
  end
end
