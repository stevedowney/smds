class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.integer :owner_id
      t.string :subject_verb, :null => false
      t.string :text, :null => false
      t.string :context
      t.integer :vote_up_count, :null => false, :default => 0
      t.integer :vote_down_count, :null => false, :default => 0
      t.integer :vote_net_count, :null => false, :default => 0
      t.integer :favorite_count, :null => false, :default => 0
      t.integer :flag_count, :null => false, :default => 0
      t.integer :comments_count, :null => false, :default => 0

      t.timestamps
    end
  end
end
