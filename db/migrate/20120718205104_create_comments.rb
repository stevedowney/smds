class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body, :null => false
      t.integer :author_id, :null => false
      t.integer :quote_id, :null => false
      t.integer :votes_up, :null => false, :default => 0
      t.integer :votes_down, :null => false, :default => 0
      t.integer :votes_net, :null => false, :default => 0

      t.timestamps
    end
  end
end
