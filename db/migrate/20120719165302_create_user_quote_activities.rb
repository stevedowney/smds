class CreateUserQuoteActivities < ActiveRecord::Migration
  def change
    create_table :user_quote_activities do |t|
      t.integer :quote_id, :null => false
      t.integer :user_id, :null => false
      t.boolean :favorite, :null => false, :default => false
      t.boolean :vote_up, :null => false, :default => false
      t.boolean :vote_down, :null => false, :default => false
      t.integer :comment_count, :null => false, :default => 0

      t.timestamps
    end
  end
end
