class Upvote < ActiveRecord::Migration
  def change
  	add_column :messages, :upvote, :integer 
  end
end
