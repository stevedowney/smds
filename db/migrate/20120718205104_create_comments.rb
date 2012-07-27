class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body, :null => false
      t.integer :author_id, :null => false
      t.integer :quote_id, :null => false
      t.integer :vote_up_count, :null => false, :default => 0
      t.integer :vote_down_count, :null => false, :default => 0
      t.integer :vote_net_count, :null => false, :default => 0
      t.integer :favorite_count, :null => false, :default => 0
      t.integer :flag_count, :null => false, :default => 0

      t.timestamps
    end
  end
end
