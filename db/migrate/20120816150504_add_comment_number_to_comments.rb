class AddCommentNumberToComments < ActiveRecord::Migration
  def change
    add_column :comments, :comment_number, :integer, :null => false, :default => 0
  end
end