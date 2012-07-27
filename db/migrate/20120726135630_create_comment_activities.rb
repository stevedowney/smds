class CreateCommentActivities < ActiveRecord::Migration
  def change
    create_table :comment_activities do |t|
			t.integer :quote_id, :null => false
			t.integer :comment_id, :null => false
      t.integer :user_id, :null => false
      t.boolean :voted_up, :null => false, :default => false
      t.boolean :voted_down, :null => false, :default => false
      t.boolean :favorited, :null => false, :default => false
      t.boolean :flagged, :null => false, :default => false
      t.timestamps
    end
  end
end
