class CreateUserQuoteActivities < ActiveRecord::Migration
  def change
    create_table :quote_activities do |t|
      t.integer :quote_id, :null => false
      t.integer :user_id, :null => false
      t.boolean :voted_up, :null => false, :default => false
      t.boolean :voted_down, :null => false, :default => false
      t.boolean :favorited, :null => false, :default => false
      t.boolean :flagged, :null => false, :default => false
      t.integer :comment_count, :null => false, :default => 0

      t.timestamps
    end
  end
end
