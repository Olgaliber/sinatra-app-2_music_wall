class AddMessages < ActiveRecord::Migration
  def change
  	create_table :messages do |t|
  		t.string :title 
  		t.string :author
  	end
  end
end
