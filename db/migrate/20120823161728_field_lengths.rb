class FieldLengths < ActiveRecord::Migration
  def up
    change_column :comments, :body, :string, :limit => 2000
    change_column :quotes, :who, :string, :limit => 100
    change_column :quotes, :text, :string, :limit => 2000
    change_column :quotes, :context, :string, :limit => 2000
  end

  def down
  end
end