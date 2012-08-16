class AddDeleteColumnsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :deleted, :boolean, :null => false, :default => false
    add_column :comments, :deleted_by, :string, :limit => 20
  end
end
