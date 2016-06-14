class AddContent < ActiveRecord::Migration
  def change
  	add_column :messages, :content, :string
  	add_column :messages, :url, :string
  	add_column :messages, :created_at, :datetime
    add_column :messages, :updated_at, :datetime 
  end
end
