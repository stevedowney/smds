class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.integer :owner_id
      t.string :subject_verb, :null => false
      t.string :text, :null => false
      t.string :context
      t.integer :votes_up, :null => false, :default => 0
      t.integer :votes_down, :null => false, :default => 0
      t.integer :votes_net, :null => false, :default => 0
      t.integer :comments_count, :null => false, :default => 0

      t.timestamps
    end
  end
end
