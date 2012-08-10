class CreateFeedbacks < ActiveRecord::Migration
  def up
    create_table :feedbacks, :force => true do |t|
      t.integer :user_id
      t.string :type, :limit => 20
      t.string :subject, :limit => 60
      t.string :body, :limit => 2000
      t.string :status, :limit => 20, :null => false, :default => 'new'
      t.timestamps
    end
  end

  def down
    drop_table :feedbacks
  end
end