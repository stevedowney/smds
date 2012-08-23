class AddUrlToQuote < ActiveRecord::Migration
  def change
    add_column :quotes, :url, :string, :limit => 250
  end
end