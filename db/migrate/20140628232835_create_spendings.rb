class CreateSpendings< ActiveRecord::Migration
  def change
    if !table_exists?("spendings")  
      create_table :spendings do |t|
        t.string   :title
        t.text     :description
        t.string   :image_url
        t.decimal  :price
        t.string   :transaction_date
        t.datetime :created_at
        t.datetime :updated_at
        t.string   :picture_file_name
        t.string   :picture_content_type
        t.integer  :picture_file_size
        t.datetime :picture_updated_at
        t.integer  :user_id
        t.string   :category
        t.datetime :transaction_date_d
        t.timestamps
      end
    end
  end
end