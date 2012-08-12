class AddTwitterUpdateIdToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :twitter_update_id_str, :string, :limit => 30
  end
  
end