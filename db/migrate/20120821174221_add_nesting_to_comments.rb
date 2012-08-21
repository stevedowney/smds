class AddNestingToComments < ActiveRecord::Migration
  def change
    add_column :comments, :parent_id, :integer
    add_column :comments, :child_comment_count, :integer, :null => false, :default => 0
    add_column :comments, :depth, :integer, :null => false, :default => 0
  end
end